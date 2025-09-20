import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/core/class/cache_helper.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../data/datasource/remote/app_data.dart';
import '../../linkapi.dart';

abstract class LoginController extends GetxController {
  login();

  goToSignUp();
}

class LoginControllerImp extends LoginController {
  AppData appData = AppData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController phone;
  late TextEditingController password;
  bool isShowPassword = true;

  StatusRequest statusRequest = StatusRequest.none;

  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  Future<void> login() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await appData.postData(AppLink.login, {
        "mobile": phone.text,
        "password": password.text,
      });

      statusRequest = StatusRequest.none;
      update();

      try {
        var responseBody = jsonDecode(response);
        print(responseBody);

        if (responseBody['user'] != null) {
          String role = responseBody['user']['role'];
           CacheHelper.putData(key: "user_id", value: responseBody['user']['id']);
           CacheHelper.putData(key: "user_name", value: responseBody['user']['name']);
           CacheHelper.putData(key: "user_location", value: responseBody['user']['location']??"0,0");
           CacheHelper.putData(key: "user_mobile", value: responseBody['user']['mobile']);
           CacheHelper.putData(key: "user_role", value: responseBody['user']['role']);
          Get.snackbar("success", responseBody['message'],colorText: Colors.white,
              backgroundColor: AppColor.primaryColor);
          if (role == 'doctor') {
            if (responseBody['medical_center'] != null) {
              CacheHelper.putData(key: "center_id", value: responseBody['medical_center']['id']);
              CacheHelper.putData(key: "center_name", value: responseBody['medical_center']['name']);
              CacheHelper.putData(key: "center_address", value: responseBody['medical_center']['address']);
              CacheHelper.putData(key: "center_phone", value: responseBody['medical_center']['phone']);

              // انتقل إلى صفحة الطبيب
               Get.offNamed(AppRoute.homeDoctor); // ضع هنا مسار صفحة الطبيب
            } else {
            Get.offNamed(AppRoute.createCenter);
            }
          } else {
            Get.offNamed(AppRoute.home);
          }
        } else {
          Get.snackbar("error", responseBody['message'],colorText: Colors.white,
              backgroundColor: AppColor.primaryColor);
        }
      } catch (e) {
        Get.snackbar("error", e.toString(),colorText: Colors.white,
            backgroundColor: AppColor.primaryColor);
        print(e.toString());
      }
    }
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signup);
  }

  @override
  void onInit() {
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}
