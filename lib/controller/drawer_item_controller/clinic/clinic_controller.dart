import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skin/core/constant/color.dart';
import '../../../core/class/statusrequest.dart';
import '../../../linkapi.dart';

class ClinicController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  List<dynamic> clinics = [];

  @override
  void onInit() {
    fetchClinic();
    super.onInit();
  }

  Future<void> fetchClinic() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      final response = await http.post(
        Uri.parse(AppLink.readClinic),
        headers: {'Content-Type': 'application/json'},
      );
      statusRequest=StatusRequest.none;
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        clinics = jsonData['data'] ?? [];
      } else {
        Get.snackbar("error", 'فشل في جلب بيانات العيادات',backgroundColor: AppColor.primaryColor);
      }
    } catch (e) {
      Get.snackbar("error", e.toString(),backgroundColor: AppColor.primaryColor);
    }
    update();
  }

  Future<void> refreshClinic() async {
    await fetchClinic();
    refreshController.refreshCompleted();
  }
}
