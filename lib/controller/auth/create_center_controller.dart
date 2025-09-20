import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/core/class/cache_helper.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../data/datasource/remote/app_data.dart';
import '../../linkapi.dart';

abstract class CreateCenterController extends GetxController {
  createCenter();
}

class CreateCenterControllerImp extends CreateCenterController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController address;
  String userId="";
  StatusRequest statusRequest = StatusRequest.none;
  AppData appData = AppData(Get.find());

  @override
  Future<void> createCenter() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await appData.postData(AppLink.createMedicalCenter, {
        "name": name.text,
        "phone": phone.text,
        "address": address.text,
        "user_id": userId,
      });

      // استلام ومعالجة الرد (اختياري)
      print(response);

      statusRequest = StatusRequest.none;
      update();
      var responseBody=jsonDecode(response);
      if(responseBody["message"]=="Medical center created successfully"){
        CacheHelper.putData(key: "center_id", value: responseBody["id"]);
        CacheHelper.putData(key: "center_name", value: name.text);
        CacheHelper.putData(key: "center_phone", value: phone.text);
        CacheHelper.putData(key: "center_address", value: address.text);
        Get.snackbar("success", responseBody['message'],colorText: Colors.white,
            backgroundColor: AppColor.primaryColor);
        Get.offNamed(AppRoute.homeDoctor); // ضع هنا مسار صفحة الطبيب

      }
    }
  }

  @override
  void onInit() {
    name = TextEditingController();
    phone = TextEditingController();
    address = TextEditingController();
    userId=Get.arguments['user_id'];
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }
}
