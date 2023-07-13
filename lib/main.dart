import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/on_boarding/on_boarding.dart';
import 'common/const/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const  Size(375,812),
      builder: (context,_) {
        return MaterialApp(
          title: 'Stay Home',
          theme: lightTheme,
          home: const Directionality(
              textDirection: TextDirection.rtl,
              child:  OnBoarding()),
        );
      }
    );
  }
}

