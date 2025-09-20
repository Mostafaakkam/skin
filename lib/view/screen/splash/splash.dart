import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../controller/auth/splash_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
Get.put(SplashController());
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (context, double opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: child,
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          AppImageAsset.logo,
          width: Get.width * 0.5, // 50% من عرض الشاشة
          height: Get.width * 0.5, // 30% من عرض الشاشة
          fit: BoxFit.fill,
        ),
      ),
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Skin Care',
                  textStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    AppColor.primaryColor,
                    AppColor.secondaryColor,
                    AppColor.accentColor,
                  ],
                  textAlign: TextAlign.center,
                ),
              ],
              isRepeatingAnimation: true,
            ),
          ],
        ),
      ),
    );
  }
}
