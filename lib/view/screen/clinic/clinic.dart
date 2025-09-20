import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/core/constant/routes.dart';

import '../../../controller/drawer_item_controller/clinic/clinic_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../linkapi.dart';

class ClinicPage extends StatelessWidget {
  const ClinicPage({super.key});

  @override
  Widget build(BuildContext context) {
  Get.put(ClinicController());

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: GetBuilder<ClinicController>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: RefreshIndicator(
              onRefresh: controller.refreshClinic,
              child: controller.clinics.isEmpty
                  ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 300),
                  Center(child: Text('لا توجد عيادات متوفرة')),
                ],
              )
                  : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: controller.clinics.length,
                itemBuilder: (context, index) {
                  final clinic = controller.clinics[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.clinicDetails,arguments: {
                      "clinic":clinic
                    }),
                    child: Container(
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
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColor.primaryColor,
                              child: const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    clinic['name'] ?? 'اسم غير معروف',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    clinic['address'] ?? 'عنوان غير محدد',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColor.primaryColor.withOpacity(0.7),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
