import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jobayaa/Screens/Home.dart';
import 'package:jobayaa/Theme.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: LightTheme,
          darkTheme: DarkTheme,
          home: jobayaaHome(),
        );
      },
    ),
  );
}
