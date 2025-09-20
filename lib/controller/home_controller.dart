
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/core/class/statusrequest.dart';
import 'package:skin/data/datasource/remote/app_data.dart';
import 'package:skin/view/screen/clinic/clinic.dart';
import 'package:skin/view/screen/diagnosis/diagnosis_page.dart';
import 'package:skin/view/screen/saved/saved_page.dart';
import '../core/class/cache_helper.dart';

class HomeController extends GetxController {
  int selectedItem = 0;
  List subScreen = [
    DiagnosisPage(),
    SavedPage(),
    ClinicPage(),
  ];
  StatusRequest statusRequest = StatusRequest.loading;
  AppData appData = AppData(Get.find());
  List screenName = [
    "التشخيص",
    "المحفوظات",
    "العيادات"

  ];
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  String name = "",
      mobile = "";
  Locale language = Locale(CacheHelper.getData(key: "lang") ??
      Get.deviceLocale!.languageCode);

  @override
  void onInit() async {
    super.onInit();
    getUserProfile();
  }


  changeIndex(int i) {
    selectedItem = i;
    closeDrawer();
    update();
  }

  void openDrawer() {
    xOffset = 230;
    yOffset = Get.height / 4.5;
    scaleFactor = 0.6;
    isDrawerOpen = true;
    update();
  }

  void closeDrawer() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    isDrawerOpen = false;
    update();
  }

  Future<void> getUserProfile() async {
    name = await CacheHelper.getData(key: "user_name");
    mobile = await CacheHelper.getData(key: "user_mobile");
    statusRequest = StatusRequest.none;

    update();

}
}
