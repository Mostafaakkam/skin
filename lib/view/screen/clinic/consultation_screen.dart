import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/core/class/handlingdataview.dart';
import 'package:skin/core/constant/color.dart';
import 'package:skin/linkapi.dart';

import '../../../controller/drawer_item_controller/clinic/consultation_controller.dart';

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ConsultationController());
    return GetBuilder<ConsultationController>(

      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text("الاستشارة",style: TextStyle(color: Colors.white),),
          backgroundColor: AppColor.primaryColor,
        ),
        body: Column(
          children: [
            // قسم بيانات التشخيص
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: controller.diagnosesData["photo"] != null && controller.diagnosesData["photo"] != ''
                        ? CachedNetworkImage(
                      imageUrl:
                      '${AppLink.server}/skin/uploads/${controller.diagnosesData["photo"]}',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, size: 40),
                    )
                        : const Icon(Icons.image_not_supported, size: 40),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                     controller.diagnosesData['result'] ?? 'لا يوجد نتيجة',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // قسم الرسائل
            Expanded(
              child: HandlingDataRequest(
                statusRequest: controller.messageStatus,
                widget: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    final isMe =
                        controller.isMyMessage(message['sender_id'].toString());

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe
                              ? AppColor.primaryColor.withOpacity(0.8)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message['content'],
                          style: TextStyle(
                              color: isMe ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // حقل كتابة الرسالة
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      decoration: const InputDecoration(
                        hintText: "اكتب رسالتك...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.sendMessage,
                    icon: Icon(Icons.send, color: AppColor.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
