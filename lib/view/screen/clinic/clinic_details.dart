import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/controller/drawer_item_controller/clinic/clinic_details_controller.dart';
import 'package:skin/core/class/handlingdataview.dart';
import 'package:skin/core/constant/color.dart';

import '../../../core/constant/routes.dart';

class ClinicDetailsPage extends StatelessWidget {
  const ClinicDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClinicDetailsController>(
      init: ClinicDetailsController(),
      builder: (controller) {
        final centerData = controller.centerData;
        final doctor = controller.doctor;

        return Scaffold(
          backgroundColor: Colors.blueGrey.shade50,
          appBar: AppBar(
            backgroundColor: AppColor.primaryColor,
            elevation: 2,

            centerTitle: true,
            title: Text(
              centerData['name'] ?? 'تفاصيل العيادة',
              style: TextStyle(color: Colors.blueGrey.shade50),
            ),
          ),
          body: HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(

                    centerData['name'] ?? 'اسم العيادة غير متوفر',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Card(
                    color: Colors.green.shade50, // الأخضر الفاتح
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    shadowColor: Colors.green.withOpacity(0.3), // ظل أخضر
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          InfoRow(label: 'العنوان', value: centerData['address'] ?? 'غير محدد'),
                          const SizedBox(height: 12),
                          InfoRow(label: 'الهاتف', value: centerData['phone'] ?? 'غير متوفر'),
                        ],
                      ),
                    ),
                  ),


                  const SizedBox(height: 30),

                  Text(
                    'طبيب العيادة',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  const SizedBox(height: 18),

                  Card(
                    color: Colors.green.shade50,
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    shadowColor: Colors.green.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.green.shade100, // خلفية دائرية خضراء فاتحة
                            child: doctor['photo'] != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                doctor['photo'],
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            )
                                : Icon(Icons.person, size: 50, color: Colors.green.shade700),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor['name'] ?? 'غير معروف',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade900, // خط أخضر داكن
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  doctor['mobile'] ?? 'غير متوفر',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),


                  const SizedBox(height: 40),

                  Row(
                    children: [
                      // Expanded(
                      //   child: ElevatedButton.icon(
                      //     onPressed: () {
                      //       Get.toNamed(AppRoute.locationPage, arguments:{
                      //         "location":doctor['location'].toString()});
                      //     },
                      //     icon: const Icon(Icons.location_on, color: Colors.white),
                      //     label: const Text('عرض الموقع',style: TextStyle(color: Colors.white),),
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: AppColor.primaryColor,
                      //       padding: const EdgeInsets.symmetric(vertical: 16),
                      //       textStyle: const TextStyle(fontSize: 18),
                      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      //       elevation: 6,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final hasConsultation = await controller.checkOrCreateConsultation();

                            if (hasConsultation) {
                              Get.toNamed(AppRoute.consultationPage,arguments: {
                                "consultationId":controller.consultationId,
                                "diagnoses":controller.diagnosesData
                              });
                            } else {
                              controller.showDiagnosisSelection();
                            }
                          },
                          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                          label: const Text('استشارة',style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(
          textDirection: TextDirection.rtl,
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade700,
            fontSize: 18,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blueGrey.shade900,
            ),
          ),
        ),
      ],
    );
  }
}
