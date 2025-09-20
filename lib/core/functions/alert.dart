import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
Future<bool> alert({required String message,
required String check,
required String cancel,
  required void Function() onCheckPressed,
  required void Function() onCancelPressed}) {
  Get.defaultDialog(
      title: "54".tr,
      titleStyle:const  TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold),
      middleText: message,
      middleTextStyle: const TextStyle(color: AppColor.grey2),
      actions: [
        ElevatedButton(
            style: ButtonStyle(

                backgroundColor:
                    MaterialStateProperty.all(AppColor.primaryColor)),
            onPressed:onCheckPressed,
            child: Text(check,style: const TextStyle(color: AppColor.white),)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.primaryColor)),
            onPressed: onCancelPressed,
            child: Text(cancel,style: const TextStyle(color: AppColor.white)))
      ]);
  return Future.value(true);
}
