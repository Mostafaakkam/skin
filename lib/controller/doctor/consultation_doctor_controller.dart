import 'dart:convert';
import 'package:get/get.dart';
import 'package:skin/core/class/statusrequest.dart';
import 'package:skin/data/datasource/remote/app_data.dart';
import '../../../core/class/cache_helper.dart';
import '../../../linkapi.dart';

class ConsultationDoctorController extends GetxController {
  List consultations = [];
  List users = [];
  List diagnoses = [];
  String centerId = '';
  StatusRequest statusRequest = StatusRequest.loading;
  AppData appData = AppData(Get.find());

  @override
  void onInit()async {
    centerId = await CacheHelper.getData(key: "center_id").toString();
    fetchAllData();
    super.onInit();
  }

  Future<void> fetchAllData() async {
    statusRequest = StatusRequest.loading;
    update();

    await Future.wait([
      fetchConsultations(),
      fetchUsers(),
      fetchDiagnoses(),
    ]);

    statusRequest = StatusRequest.none;
    update();
  }

  Future<void> fetchConsultations() async {
    final response = await appData.postData(AppLink.doctorConsultation,{'id':centerId});
    final data = jsonDecode(response);
    if (data['data']!=null) {
      consultations = data['data'];
    }
  }

  Future<void> fetchUsers() async {
    final response = await appData.getData(AppLink.getUsers); // رابط PHP لجلب المستخدمين
    final data = jsonDecode(response);
    if (data['data']!=null) {
      users = data['data'];
    }
  }

  Future<void> fetchDiagnoses() async {
    final response = await appData.getData(AppLink.getAllDiagnosis);
    final data = jsonDecode(response);
    if (data['data']!=null) {
      diagnoses = data['data'];
    }
  }

  Map<String, dynamic>? getUserById(String id) {
    return users.firstWhereOrNull((user) => user['id'].toString() == id);
  }

  Map<String, dynamic>? getDiagnosisById(String id) {
    return diagnoses.firstWhereOrNull((diag) => diag['id'].toString() == id);
  }
}
