import 'package:get/get.dart';

import '../constant/color.dart';

Future<void> appSnackBar({required String label, required String text})
async {
  Get.snackbar(label, text, colorText: AppColor.white,
  backgroundColor: AppColor.primaryColor);
}
