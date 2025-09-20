import 'package:flutter/material.dart';

import '../../../../../core/constant/color.dart';

Row buildAppBar({
  required bool isDrawerOpen,
  required void Function() openDrawer,
  required void Function() closeDrawer,
  required String screenName,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      isDrawerOpen
          ? IconButton(
              onPressed: () => closeDrawer(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColor.primaryColor,
                size: 25.0,
              ),
            )
          : IconButton(
              onPressed: () => openDrawer(),
              icon: const Icon(
                Icons.menu,
                color: AppColor.primaryColor,
                size: 25.0,
              ),
      ),
      Text(
        screenName,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
      ),
    ],
  );
}
