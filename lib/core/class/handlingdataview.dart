import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skin/core/class/statusrequest.dart';
import '../constant/color.dart';
import '../constant/imgaeasset.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final Widget loadingWidget;

  const HandlingDataView(
      {super.key,
      required this.statusRequest,
      required this.widget,
      required this.loadingWidget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: loadingWidget)
        : statusRequest == StatusRequest.offlinefailure
            ? Center(
        child: Column(children: [
          Lottie.asset(AppImageAsset.noData,
              width: 200, height: 200),
          const Text(
            "خطأ في معالجة الطلب",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: AppColor.primaryColor),
          )
        ]))
            : statusRequest == StatusRequest.serverfailure
                ? Center(
        child: Column(children: [
          Lottie.asset(AppImageAsset.noData,
              width: 200, height: 200),
          const Text(
            "خطأ في معالجة الطلب",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: AppColor.primaryColor),
          )
        ]))
                : statusRequest == StatusRequest.serverException
                    ?Center(
        child: Column(children: [
          Lottie.asset(AppImageAsset.noData,
              width: 200, height: 200),
          const Text(
            "خطأ في معالجة الطلب",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: AppColor.primaryColor),
          )
        ]))
                    : statusRequest == StatusRequest.failure
                        ? Center(
                            child: Column(children: [
                            Lottie.asset(AppImageAsset.noData,
                                width: 200, height: 200),
                                              const Text(
                              "أنت غير متصل بالإنترنت",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.primaryColor),
                            )
                          ]))
                        : statusRequest == StatusRequest.noData
                            ? Center(
        child: Column(children: [
          Lottie.asset(AppImageAsset.noData,
              width: 200, height: 200),
           Text(
            "58".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16, color: AppColor.primaryColor),
          )
        ]))
                            : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataRequest(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Lottie.asset(AppImageAsset.loading, width: 200, height: 200))
        : statusRequest == StatusRequest.offlinefailure
            ?Center(
        child: Column(children: [
          Lottie.asset(AppImageAsset.noData,
              width: 200, height: 200),
          const Text(
            "أنت غير متصل بالإنترنت",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: AppColor.primaryColor),
          )
        ]))
            : statusRequest == StatusRequest.serverfailure
                ? Center(
        child: Column(children: [
          Lottie.asset(AppImageAsset.noData,
              width: 200, height: 200),
          const Text(
            "خطأ في معالجة الطلب",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: AppColor.primaryColor),
          )
        ]))
                : statusRequest == StatusRequest.noData
                    ? Center(
        child: Column(children: [
          Lottie.asset(AppImageAsset.noData,
              width: 200, height: 200),
           Text(
            "58".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16, color: AppColor.primaryColor),
          )
        ]))
                    : statusRequest == StatusRequest.serverException
                        ? Center(
        child: Column(children: [
          Lottie.asset(AppImageAsset.noData,
              width: 200, height: 200),
          const Text(
            "خطأ في معالجة الطلب",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: AppColor.primaryColor),
          )
        ]))
                        : widget;
  }
}
