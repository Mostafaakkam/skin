import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';

class UpdateButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const UpdateButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all( 8),

      child: MaterialButton(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 13),
        onPressed: onPressed,
        color: AppColor.primaryColor,
        disabledColor:AppColor.primaryColor,
        focusColor: AppColor.primaryColor,
        textColor: Colors.white,
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
