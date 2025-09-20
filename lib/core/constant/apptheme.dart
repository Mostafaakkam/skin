import 'package:flutter/material.dart';
import 'color.dart';

ThemeData themeEnglish = ThemeData(
  fontFamily: "PlayfairDisplay",
  primaryColor: AppColor.primaryColor,
  scaffoldBackgroundColor: AppColor.neutralColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryColor,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColor.primaryColor),
    titleTextStyle: TextStyle(
      color: AppColor.white,
      fontWeight: FontWeight.bold,
      fontFamily: "PlayfairDisplay",
      fontSize: 25,
    ),
    backgroundColor: AppColor.primaryColor,
  ),




);

ThemeData themeArabic = ThemeData(
  fontFamily: "Cairo",
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryColor,
  ),
  primaryColor: AppColor.primaryColor,
  scaffoldBackgroundColor: AppColor.neutralColor,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColor.primaryColor),
    titleTextStyle: TextStyle(
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontFamily: "Cairo",
      fontSize: 25,
    ),
    backgroundColor: Colors.white,
  ),


);
