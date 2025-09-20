import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/core/constant/color.dart';
import '../../../controller/drawer_item_controller/diagnosis/diagnosis_controller.dart';
import '../../../core/class/statusrequest.dart';
import '../../widget/image_picker_bottom_sheet.dart';

class DiagnosisPage extends StatelessWidget {
  const DiagnosisPage({super.key});

  void _showImagePickerBottomSheet(BuildContext context, DiagnosisController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ImagePickerBottomSheet(
        onPickImage: (pickedFile) {
          if (pickedFile != null) {
            controller.pickImage(File(pickedFile.path));
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(DiagnosisController());

    return GetBuilder<DiagnosisController>(
      builder: (controller) {
        return Scaffold(

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _showImagePickerBottomSheet(context, controller),
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      border: Border.all(color: Colors.blueGrey.shade200),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
                      ],
                    ),
                    child: controller.selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        controller.selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                        : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 60, color: Colors.blueGrey),
                          SizedBox(height: 8),
                          Text("اضغط لاختيار صورة", style: TextStyle(color: Colors.blueGrey)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _showImagePickerBottomSheet(context, controller),
                      icon: const Icon(Icons.photo_library,color: Colors.white,),
                      label: const Text("تحديد صورة",style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (controller.selectedImage != null)
                      ElevatedButton.icon(
                        onPressed: controller.uploadImageAndGetResult,
                        icon: const Icon(Icons.medical_services,color: Colors.white,),
                        label: const Text("فحص",style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                if (controller.statusRequest == StatusRequest.loading)
                  const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text("جاري الفحص...", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                if (controller.diagnosis != null)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("نتائج الفحص", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(
                            textDirection: TextDirection.rtl,
                            'الحالة: ${controller.diagnosis}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            textDirection: TextDirection.rtl,
                            'الدقة: ${controller.confidence}',
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 20),
                          controller.diagnosis != "other"&&controller.diagnosis != "normal"?
                          ElevatedButton.icon(
                            onPressed: controller.isSaving ? null : controller.saveDiagnosis,
                            icon: const Icon(Icons.save,color: Colors.white,),
                            label: Text(controller.isSaving ? "جاري الحفظ..." : "حفظ التشخيص",style:
                              TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.isSaving ? Colors.grey : AppColor.primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ):SizedBox(),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
