import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == "username") {
    RegExp regExp = RegExp('[0-9!"#\$%&\'()*+,\-./:;<=>?@\[\\\]^_`{|}~]');
     if(regExp.hasMatch(val)) {
       return "أسم المستخدم غير صالح";
     }

  }


  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "رقم الموبايل غير صالح";
    }
  }

  if (val.isEmpty) {
    return "لا يجب أن يكون هذا الحقل فارغ";
  }

  if (val.length < min) {
    return " لا يجب أن يكون أصغر من$min";
  }

  if (val.length > max) {
    return " لا يجب أن يكون أكبر من$max";
  }
}
