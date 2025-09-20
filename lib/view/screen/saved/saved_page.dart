import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skin/core/class/handlingdataview.dart';
import 'package:skin/linkapi.dart';
import '../../../controller/drawer_item_controller/saved/saved_controller.dart';
import '../../../core/constant/color.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SavedController());

    return GetBuilder<SavedController>(
      builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: RefreshIndicator(
            onRefresh: () => controller.fetchSaved(),
            child: controller.savedDiagnoses.isEmpty
                ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 300),
                Center(child: Text("لا توجد تشخيصات محفوظة")),
              ],
            )
                : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: controller.savedDiagnoses.length,
              itemBuilder: (context, index) {
                final item = controller.savedDiagnoses[index];
                final imageUrl = '${AppLink.server}/skin/uploads/${item['photo']}';

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: AppColor.primaryColor.withOpacity(0.3),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
                            errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 40),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'النتيجة: ${item['result']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.deleteDiagnosis(item['id'].toString()),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
