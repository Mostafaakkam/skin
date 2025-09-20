import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../widget/drawer/components/build_app_bar.dart';
import '../widget/drawer/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (controller) =>Scaffold(
        body:  Stack(
            children: [
              /// القائمة الجانبية تكون في الخلف
              DrawerScreen(
                diagnosisTap: () => controller.changeIndex(0),
                savedTap: () => controller.changeIndex(1),
                clinicTap: () => controller.changeIndex(2),


                selected: controller.selectedItem,
              ),

              /// الشاشة الرئيسية تكون متحركة عند فتح القائمة
              AnimatedContainer(
                width: Get.width,
                height: Get.height,
                transform: Matrix4.translationValues(
                    controller.xOffset, controller.yOffset, 0)
                  ..scale(controller.scaleFactor),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: controller.isDrawerOpen
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )
                      : BorderRadius.zero,
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: Get.height*.03,
                      child: buildAppBar(
                        screenName: controller.screenName[controller.selectedItem],
                        isDrawerOpen: controller.isDrawerOpen,
                        openDrawer: controller.openDrawer,
                        closeDrawer: controller.closeDrawer,
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: Get.height*.08),
                    child: controller.subScreen[controller.selectedItem],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
