import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/routes.dart';
import 'bindings/intialbindings.dart';
import 'core/class/cache_helper.dart';
import 'core/constant/apptheme.dart';
import 'core/constant/routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = themeArabic;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'skin',
      initialRoute: AppRoute.splash,
      theme: appTheme,
      locale: Locale("en"),
      initialBinding: InitialBindings(),
      getPages: routes,
    );
  }
}
