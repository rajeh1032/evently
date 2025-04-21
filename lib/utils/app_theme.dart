import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          color: AppColors.whiteColor,
          iconTheme: IconThemeData(color: AppColors.primaryLight)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: StadiumBorder(
            side: BorderSide(
          color: AppColors.whiteColor,
          width: 4,
        )),
        backgroundColor: AppColors.primaryLight,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          selectedLabelStyle: AppStyles.bold12White,
          unselectedLabelStyle: AppStyles.bold12White,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.whiteColor),
      primaryColor: AppColors.primaryLight,
      focusColor: AppColors.whiteColor,
      hintColor: AppColors.primaryLight,
      hoverColor: AppColors.blackColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20Black,
          headlineSmall: AppStyles.medium18Black));
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
  static final ThemeData darkTheme = ThemeData(
      appBarTheme: AppBarTheme(
          color: AppColors.primaryDark,
          iconTheme: IconThemeData(color: AppColors.primaryLight)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: StadiumBorder(
            side: const BorderSide(
          color: AppColors.whiteColor,
          width: 4,
        )),
        backgroundColor: AppColors.primaryDark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          selectedLabelStyle: AppStyles.bold12White,
          unselectedLabelStyle: AppStyles.bold12White,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.whiteColor),
      primaryColor: AppColors.primaryDark,
      focusColor: AppColors.primaryLight,
      hintColor: AppColors.whiteColor,
      hoverColor: AppColors.whiteColor,
      scaffoldBackgroundColor: AppColors.primaryDark,
      textTheme: TextTheme(
        headlineLarge: AppStyles.bold20White,
        headlineSmall: AppStyles.medium18White,
      ));
}
