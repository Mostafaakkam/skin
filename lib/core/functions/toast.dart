import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';

void showToast({
  required String text,
}) {
  ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
    SnackBar(

      backgroundColor: AppColor.primaryColor,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      duration: const Duration(milliseconds: 1000),
    ),
  );
}
