import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:skin/linkapi.dart';
import '../../../core/class/cache_helper.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../data/datasource/remote/app_data.dart';

class SavedController extends GetxController {
  AppData appData = AppData(Get.find());

  StatusRequest statusRequest = StatusRequest.loading;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  List<Map<String, dynamic>> savedDiagnoses = [];


  Future<void> fetchSaved() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final userId = await CacheHelper.getData(key: "user_id");

      final response = await http.post(
        Uri.parse(AppLink.readDiagnosis),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': userId.toString()}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        savedDiagnoses = List<Map<String, dynamic>>.from(data['data']);
        statusRequest = StatusRequest.success;
      } else {
        savedDiagnoses.clear();
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  Future<void> deleteDiagnosis(String id) async {
    try {
      final response = await http.post(
        Uri.parse(AppLink.deleteDiagnosis),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );
      print(response.body);

      if (response.statusCode == 200) {
        savedDiagnoses.removeWhere((item) => item['id'].toString() == id);
        update();
        Get.snackbar("تم الحذف", "تم حذف التشخيص بنجاح",
            backgroundColor: AppColor.primaryColor, colorText: Colors.white);
      } else {
        Get.snackbar("فشل", "فشل في حذف التشخيص",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الحذف",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void refreshSaved() async {
    await fetchSaved();
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    fetchSaved();
    super.onInit();
  }
}
