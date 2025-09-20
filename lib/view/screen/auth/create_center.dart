import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/create_center_controller.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../widget/auth/background_widget.dart';
import '../../widget/auth/customtextformauth.dart';

class CreateCenter extends StatelessWidget {
  const CreateCenter({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateCenterControllerImp());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<CreateCenterControllerImp>(
        builder: (controller) => Stack(
          children: [
            const BackgroundWidget(),
            Positioned(
              top: Get.height * 0.1,
              child: SizedBox(
                width: Get.width,
                child: const Text(
                  "Create Medical Center",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: Get.height * 0.05,
              child: SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Create",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          FloatingActionButton(
                            shape: const CircleBorder(),
                            onPressed: () => controller.createCenter(),
                            child: controller.statusRequest == StatusRequest.none
                                ? const Icon(Icons.check, color: AppColor.white)
                                : const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(color: AppColor.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: controller.formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormAuth(
                      isNumber: false,
                      valid: (val) => val!.isEmpty ? "Enter center name" : null,
                      mycontroller: controller.name,
                      hinttext: "Medical center name",
                      iconData: Icons.local_hospital,
                      labeltext: "Name",
                    ),
                    CustomTextFormAuth(
                      isNumber: true,
                      valid: (val) => val!.isEmpty ? "Enter phone number" : null,
                      mycontroller: controller.phone,
                      hinttext: "Medical center phone",
                      iconData: Icons.phone,
                      labeltext: "Phone",
                    ),
                    CustomTextFormAuth(
                      isNumber: false,
                      valid: (val) => val!.isEmpty ? "Enter address" : null,
                      mycontroller: controller.address,
                      hinttext: "Medical center address",
                      iconData: Icons.location_on,
                      labeltext: "Address",
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
