import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../controller/auth/signup_controller.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/background_widget.dart';
import '../../widget/auth/customtextformauth.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<SignUpControllerImp>(builder: (controller) => Stack(
        children: [
          const BackgroundWidget(),
          Positioned(
            top: Get.height * 0.1,
            child: SizedBox(
              width: Get.width,
              child: Text(
                "Welcome",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white),
              ),
            ),
          ),
          Positioned(
            bottom: Get.height * 0.05,
            child: SizedBox(
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("signup",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        FloatingActionButton(
                          shape: const CircleBorder(),
                          onPressed: () => controller.signUp(),
                          child: controller.statusRequest == StatusRequest.none
                              ? const Icon(
                            Icons.arrow_forward,
                            color: AppColor.white,
                          )
                              : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: AppColor.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.offNamed(AppRoute.login),
                          child: const Text("have account? to login",
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                  )
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 3, 20, "name");
                    },
                    mycontroller: controller.fullName,
                    hinttext: "enter full name",
                    iconData: Icons.person,
                    labeltext: "enter full name",
                  ),
                  CustomTextFormAuth(
                    isNumber: true,
                    valid: (val) {
                      return validInput(val!, 10, 10, "phone");
                    },
                    mycontroller: controller.phone,
                    hinttext: "enter mobile",
                    iconData: FontAwesomeIcons.mobileScreen,
                    labeltext: "enter mobile",
                  ),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 8, 20, "password");
                    },
                    mycontroller: controller.password,
                    hinttext: "enter password",
                    iconData: !controller.isShowPassword
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    labeltext: "enter password",
                    onTapIcon: () => controller.showPassword(),
                    obscureText: controller.isShowPassword,
                  ),
                  const SizedBox(height: 10),
                  // 👇 Radio Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("اختر نوع الحساب:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                title: const Text("دكتور"),
                                value: "doctor",
                                groupValue: controller.role,
                                onChanged: (val) =>
                                    controller.changeRole(val!),
                                activeColor: AppColor.primaryColor,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: const Text("مريض"),
                                value: "user",
                                groupValue: controller.role,
                                onChanged: (val) =>
                                    controller.changeRole(val!),
                                activeColor: AppColor.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
