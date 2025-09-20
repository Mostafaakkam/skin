import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/core/class/cache_helper.dart';
import 'package:skin/core/class/handlingdataview.dart';
import 'package:skin/core/class/statusrequest.dart';
import 'package:skin/core/constant/routes.dart';
import 'package:skin/data/datasource/remote/app_data.dart';
import '../../../core/constant/color.dart';
import '../../../linkapi.dart';

class ClinicDetailsController extends GetxController {
  late Map<String, dynamic> centerData;
  Map<String, dynamic> consultationData={};
  late Map<String, dynamic> doctor;
  List<Map<String, dynamic>> savedDiagnoses = [];
  Map<String, dynamic>diagnosesData ={};

  AppData appData=AppData(Get.find());
  // متغير حالة التحميل
StatusRequest statusRequest=StatusRequest.loading;
StatusRequest savedStatusRequest=StatusRequest.none;
String userId='';
String centerId='';
String consultationId='';

  @override
  void onInit() async{
    super.onInit();

    centerData = Get.arguments["clinic"] ?? {};
    doctor = centerData['doctor'] ?? {};
    userId=await CacheHelper.getData(key: "user_id").toString();
    centerId=centerData["id"].toString();
   await fetchSaved();
  }
  Map<String, dynamic>? getDiagnosisById(String id) {
    try {
      return savedDiagnoses.firstWhere(
            (element) => element['id'].toString() == id,
        orElse: () => {},
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> createConsultation(Map<String, dynamic> diagnosis) async {
   Get.back();
    statusRequest=StatusRequest.loading;
    update();

    final now = DateTime.now().toIso8601String();

    final response = await appData.postData(
      AppLink.createConsultation,
      {
        'user_id': userId.toString(),
        'center_id': centerId.toString(),
        'date_time': now,
        'diagnosis_id': diagnosis['id'].toString(),
      },
    );

   statusRequest=StatusRequest.none;
    var responseBody=jsonDecode(response);
    if (responseBody['success']) {
      // ممكن تحفظ ID الاستشارة أو أي بيانات حسب الحاجة
      consultationId = responseBody['id'];
      print('Consultation created with ID: $consultationId');
      diagnosesData=diagnosis;
      Get.snackbar("success", "تم انشاء الاستشارة بنجاح",colorText: Colors.white,
      backgroundColor: AppColor.primaryColor);
      update();
      Get.toNamed(AppRoute.consultationPage,arguments: {
        "consultationId":consultationId,
        "diagnoses":diagnosesData
      });
    } else {
      // التعامل مع الخطأ (اختياري)
      Get.snackbar('خطأ', response.message ?? 'فشل في إنشاء الاستشارة',colorText: Colors.white,
      backgroundColor: AppColor.primaryColor);
    }
  }

  Future<bool> checkOrCreateConsultation() async {
    statusRequest=StatusRequest.loading;
    update();

    final response = await appData.postData(
      AppLink.checkConsultation,
      {
        'user_id': userId.toString(),
        'center_id': centerId.toString(),
      },
    );


    statusRequest=StatusRequest.none;
    savedStatusRequest=StatusRequest.none;
    var responseBody=jsonDecode(response);
    print(responseBody);
    if (responseBody["success"]) {
      consultationData=responseBody['data'];
      consultationId=consultationData['id'].toString();
      diagnosesData=getDiagnosisById(responseBody['data']['diagnosis_id'].toString())!;
      print(diagnosesData['photo']);
update();
      return true;
    } else {
      update();

      return false;
    }
  }

  Future<void> fetchSaved() async {
    try {
      savedStatusRequest = StatusRequest.loading;
      update();


      final response = await await appData.postData(
        AppLink.readDiagnosis,
         {'id': userId.toString()},
      );
      savedStatusRequest=StatusRequest.none;
      statusRequest=StatusRequest.none;

      final data = jsonDecode(response);
      print(data);

      if (data['data']!=null) {
        savedDiagnoses = List<Map<String, dynamic>>.from(data['data']);
      } else {
        savedDiagnoses.clear();
      }
    } catch (e) {
    }

    update();
  }

  void showDiagnosisSelection()async {
    await fetchSaved();
    Get.bottomSheet(
     Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: HandlingDataRequest(
            statusRequest: savedStatusRequest,
            widget:  Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                "اختر تشخيصاً محفوظاً لإنشاء الاستشارة",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: savedDiagnoses.length,
                  itemBuilder: (context, index) {
                    final item = savedDiagnoses[index];
                    final imageUrl = '${AppLink.server}/skin/uploads/${item['photo']}';

                    return GestureDetector(
                      onTap: () => createConsultation(savedDiagnoses[index]),
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

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
