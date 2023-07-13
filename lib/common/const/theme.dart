import 'package:driver_project/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide(color: AppColors.grey),

    ),

  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      padding: EdgeInsets.symmetric(vertical: 12.r,horizontal: 48.r),
      textStyle: TextStyle(color: AppColors.white,fontWeight: FontWeight.w700,fontSize: 14.sp),
      foregroundColor: AppColors.white
    ))
  );
