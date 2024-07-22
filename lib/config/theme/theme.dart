import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iqchallenges/core/utils/appcolors.dart';

class AppTheme {
  static ThemeData darktheme() {
    return ThemeData(
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.black),
      dialogBackgroundColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.white),
        actionsIconTheme: IconThemeData(color: AppColors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.black,
        ),
      ),
      primaryColor: HexColor('F4A135'),
    );
  }
}
