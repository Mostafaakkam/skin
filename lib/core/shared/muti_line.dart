import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';

class MultiLine extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final int? maxLines; // أضف خاصية للتحكم في عدد الأسطر

  const MultiLine({
    super.key,
    this.obscureText,
    this.onTapIcon,
    required this.hinttext,
    required this.labeltext,
    required this.iconData,
    required this.mycontroller,
    required this.valid,
    required this.isNumber,
    this.maxLines, // يمكن تمرير عدد الأسطر المطلوبة
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        cursorColor: AppColor.primaryColor,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.multiline, // تغيير نوع الإدخال ليدعم النصوص متعددة الأسطر
        textInputAction: TextInputAction.newline, // السماح بالانتقال لسطر جديد
        maxLines: maxLines ?? null,
        minLines: 1,// إذا لم يتم تحديد عدد أسطر، يكون غير محدود
        validator: valid,
        controller: mycontroller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          label: Container(
            margin: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              labeltext,
              style: const TextStyle(color: AppColor.primaryColor),
            ),
          ),
          suffixIcon: InkWell(
            onTap: onTapIcon,
            child: Icon(
              iconData,
              color: AppColor.primaryColor,
              size: 20,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColor.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColor.primaryColor, width: 2),
          ),
        ),
      ),
    );
  }
}
