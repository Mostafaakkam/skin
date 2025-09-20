import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/doctor/consultation_doctor_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';

class ConsultationDoctorPage extends StatelessWidget {
  const ConsultationDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ConsultationDoctorController());

    return Scaffold(

      body: GetBuilder<ConsultationDoctorController>(
        builder: (controller) => HandlingDataRequest(

          statusRequest: controller.statusRequest,
          widget: ListView.builder(
            itemCount: controller.consultations.length,
            itemBuilder: (context, index) {
              final consultation = controller.consultations[index];
              final user = controller.getUserById(consultation['user_id'].toString());
              final userName = user?['name'] ?? 'غير معروف';

              return GestureDetector(
                onTap: () =>  Get.toNamed(AppRoute.consultationPage,arguments: {
                  "consultationId":controller.consultations[index]['id'].toString(),
                  "diagnoses":controller.getDiagnosisById(controller.consultations[index]['diagnosis_id'].toString())
                }),
                child: Card(
                  child: ListTile(
                    
                    leading: const Icon(Icons.medical_services, color: AppColor.primaryColor),
                    title: Text( userName),
                    subtitle: Text("التاريخ: ${consultation['date_time']}"),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
