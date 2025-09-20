import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skin/core/class/statusrequest.dart';
import 'package:skin/core/constant/color.dart';
import '../../../controller/auth/login_controller.dart';
import '../../../core/constant/routes.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/background_widget.dart';
import '../../widget/auth/customtextformauth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<LoginControllerImp>(
        builder: (controller) =>
            Stack(
              children: [
                const BackgroundWidget(),
                Positioned(
                  top: Get.height * 0.1,
                  child: SizedBox(
                    width: Get.width,
                    child: Text(
                      "Welcome Back",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white),
                    ),
                  ),
                ),
                Positioned(
                    bottom: Get.height * 0.1,
                    child: SizedBox(
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: Get.width / 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("login",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                FloatingActionButton(
                                  shape: const CircleBorder(),
                                  onPressed: ()=>controller.login(),
                                  child: controller.statusRequest ==
                                      StatusRequest.none ?
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: AppColor.white,
                                  ):const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(color: AppColor.white,),
                                  ),

                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: Get.width / 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.offNamed(AppRoute.signup),
                                  child: Text("don't have account?to signup".tr,
                                      style: const TextStyle(
                                          decoration: TextDecoration
                                              .underline)),
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: controller.formState,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10), // Space between fields
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
                    //    const SizedBox(height: 20),
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
                          // mycontroller: ,
                        ),
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
