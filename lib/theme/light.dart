import 'package:flutter/material.dart';
import '/theme/appColors.dart';

class LightTheme {
  static themeDatas() {
    return ThemeData(
        fontFamily: 'Urbanist',
        backgroundColor: AppColors.backgroundColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        inputDecorationTheme: inputDecorationTheme(),
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 15),
          bodyText2: TextStyle(fontSize: 15),
          headline1: TextStyle(fontSize: 15),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
        ));
  }

  static inputDecorationTheme() {
    return InputDecorationTheme(
      errorStyle: TextStyle(fontSize: 13, color: AppColors.danger),
      helperStyle: TextStyle(fontSize: 13, color: AppColors.danger),
      hintStyle: TextStyle(fontSize: 13, color: AppColors.textLight),
      labelStyle: TextStyle(fontSize: 13, color: AppColors.textLight),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      alignLabelWithHint: false,
      fillColor: AppColors.white,
      filled: true,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35),
        borderSide: BorderSide(color: AppColors.grey, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35),
        borderSide: BorderSide(color: AppColors.grey, width: 0.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35),
        borderSide: BorderSide(color: Colors.red, width: 0.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35),
        borderSide: BorderSide(color: Colors.red, width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35),
        borderSide: BorderSide(color: AppColors.grey, width: 0.5),
      ),
    );
  }
}
