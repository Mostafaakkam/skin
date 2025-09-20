import 'package:get/get.dart';

import '../../core/class/cache_helper.dart';
import '../../core/constant/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkOfUser();
    super.onInit();
  }

  void checkOfUser() async {
    print(await CacheHelper.getData(key: "center_id"));
    print(await CacheHelper.getData(key: "user_role"));
    print(await CacheHelper.getData(key: "user_id"));
    await Future.delayed(
      const Duration(seconds: 4),
      () async {
        if ((await CacheHelper.getData(key: "user_id") == "" ||
            await CacheHelper.getData(key: "user_id") == null)) {
          Get.offAllNamed(AppRoute.login);
        }  else {
          if (await CacheHelper.getData(key: "user_role") == "doctor"){
            if ((await CacheHelper.getData(key: "center_id").toString() != "" ||
                await CacheHelper.getData(key: "center_id") != null)) {
             Get.offNamed(AppRoute.homeDoctor);
            }
            else{
              Get.offAllNamed(AppRoute.createCenter,arguments: {
                "user_id":await CacheHelper.getData(key: "user_id").toString()
              });            }
            }else{
            Get.offAllNamed(AppRoute.home);

          }
          }
        }

    );
  }
}
