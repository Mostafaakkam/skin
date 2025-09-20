import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:skin/core/class/cache_helper.dart';
import 'package:skin/core/constant/color.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../data/datasource/remote/app_data.dart';
import '../../linkapi.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController fullName;
  late TextEditingController phone;
  late TextEditingController password;

  StatusRequest statusRequest = StatusRequest.none;
  bool isShowPassword = true;
  String role = "user"; // القيمة الافتراضية
  String location="";
  AppData appData = AppData(Get.find());

  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  void changeRole(String value) {
    role = value;
    update();
  }

  @override
  Future<void> signUp() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await appData.postData(AppLink.signUp, {
        "name": fullName.text,
        "mobile": phone.text,
        "password": password.text,
        "role": role,
      });
       print(response);
      statusRequest = StatusRequest.none;
      update();
       var responseDecode=jsonDecode(response);
      if (responseDecode['message'] == "User registered successfully") {
        // إذا كان دكتور يمكن إنشاء عيادة مباشرة أو الذهاب لواجهة إدخال بيانات العيادة
        Get.snackbar("success", responseDecode['message'],colorText: Colors.white,
            backgroundColor: AppColor.primaryColor);
        CacheHelper.putData(key: "user_id", value: responseDecode['user_id'].toString());
        CacheHelper.putData(key: "user_mobile", value: phone.text);
        CacheHelper.putData(key: "user_name", value: fullName.text);
        if (role == "doctor") {

          // مثال: الذهاب إلى صفحة إنشاء العيادة
          Get.offNamed(AppRoute.createCenter, arguments: {
            "user_id": responseDecode['user_id'].toString(), // تأكد أن PHP يرجع ID المستخدم
          });
        } else {
        Get.offNamed(AppRoute.home);
        }
      } else {
        Get.snackbar("error", responseDecode['message'] ?? "فشل التسجيل",colorText: Colors.white,
        backgroundColor: AppColor.primaryColor);
      }
    }
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    fullName = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    fullName.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}
