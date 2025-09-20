import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/core/class/cache_helper.dart';
import 'package:skin/core/class/statusrequest.dart';
import 'package:skin/data/datasource/remote/app_data.dart';
import 'package:skin/linkapi.dart';

class ConsultationController extends GetxController {
  Map<String, dynamic> diagnosesData={};
   String consultationId='';

  List<Map<String, dynamic>> messages = [];
  StatusRequest messageStatus = StatusRequest.none;
  TextEditingController messageController = TextEditingController();
  String userId = '';
  AppData appData = AppData(Get.find());

  @override
  void onInit() async {
    super.onInit();
    userId = await CacheHelper.getData(key: 'user_id').toString();
    diagnosesData=Get.arguments['diagnoses'];
    consultationId=Get.arguments['consultationId'];
    print(diagnosesData['photo']);
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    messageStatus = StatusRequest.loading;
    update();
    final response = await appData.postData(AppLink.readMessage, {
      'consultation_id': consultationId,
    });

    final data = jsonDecode(response);
    if (data['success']) {
      messages = List<Map<String, dynamic>>.from(data['data']);
    } else {
      messages.clear();
    }
    messageStatus = StatusRequest.none;
    update();
  }

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    final content = messageController.text.trim();
    final now = DateTime.now().toIso8601String();

    final response = await appData.postData(AppLink.sendMessage, {
      'consultation_id': consultationId,
      'sender_id': userId,
      'created_at': now,
      'content': content,
    });

    final data = jsonDecode(response);
    if (data['success']) {
      messageController.clear();
      fetchMessages();
    } else {
      Get.snackbar("خطأ", "فشل في إرسال الرسالة");
    }
  }

  bool isMyMessage(String senderId) => senderId == userId;
}
