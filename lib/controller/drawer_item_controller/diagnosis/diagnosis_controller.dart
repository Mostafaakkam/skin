import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:skin/core/constant/color.dart';
import 'package:skin/linkapi.dart';

import '../../../core/class/cache_helper.dart';
import '../../../core/class/statusrequest.dart';
import '../../../data/datasource/remote/app_data.dart';

class DiagnosisController extends GetxController {
  late AppData appData;

  File? selectedImage;
  String? diagnosis;
  String? confidence;
  StatusRequest statusRequest = StatusRequest.none;
  bool isSaving = false;

  @override
  void onInit() {
    appData = AppData(Get.find());
    super.onInit();
  }

  void pickImage(File file) {
    selectedImage = file;
    diagnosis = null;
    confidence = null;
    update();
  }

  Future<void> uploadImageAndGetResult() async {
    if (selectedImage == null) return;

    statusRequest = StatusRequest.loading;
    diagnosis = null;
    confidence = null;
    update();

    try {
      final uri = Uri.parse(AppLink.diagnosis);
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', selectedImage!.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final jsonResp = json.decode(respStr);
        print(jsonResp);

        diagnosis = jsonResp['type'];
        confidence = jsonResp['confidence'];
        statusRequest = StatusRequest.success;
      } else {
       Get.snackbar("error", "diagnosis failed",colorText: Colors.white,backgroundColor: AppColor.primaryColor);
      }
    } catch (e) {
      Get.snackbar("error", e.toString(),colorText: Colors.white,backgroundColor: AppColor.primaryColor);
    }

    update();
  }

  Future<void> saveDiagnosis() async {
    if (diagnosis == null || selectedImage == null) return;

    isSaving = true;
    update();

    try {
      final uri = Uri.parse(AppLink.createDiagnosis);
      final request = http.MultipartRequest('POST', uri);
      request.fields['result'] = diagnosis!;
      request.fields['user_id'] = await CacheHelper.getData(key: "user_id").toString();

      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        selectedImage!.path,
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response);
      if (response.statusCode == 200) {
         selectedImage=null;
         diagnosis = null;
         confidence = null;
         isSaving = false;
        Get.snackbar("نجاح", "تم حفظ التشخيص بنجاح", backgroundColor: AppColor.primaryColor, colorText: Colors.white);
      } else {
        Get.snackbar("خطأ", "فشل في حفظ التشخيص", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الحفظ: $e", backgroundColor: Colors.red, colorText: Colors.white);
    }

    isSaving = false;
    update();
  }
}
