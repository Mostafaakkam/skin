import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin/core/class/cache_helper.dart';
import 'package:skin/core/constant/color.dart';
import 'package:skin/core/constant/routes.dart';

import '../../../core/shared/spacing_widgets.dart';
import 'components/app_bar.dart';
import 'components/menu_items.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key,
     required this.diagnosisTap,
    required this.savedTap,
    required this.clinicTap,
    required this.selected});
  final void Function() diagnosisTap;
  final void Function() savedTap;
  final void Function() clinicTap;

  final int selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            addVerticalSpace(60.0),
            const DrawerAppBar(),
            const Spacer(),
             MenuItems(
               diagnosisTap: diagnosisTap,
               savedTap: savedTap,
               clinicTap: clinicTap,
               selected: selected,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () async {
                  CacheHelper.clear();
                  Get.offAllNamed(AppRoute.login);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.logout, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'تسجيل الخروج',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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
