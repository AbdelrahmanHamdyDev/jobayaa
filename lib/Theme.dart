import 'package:flutter/material.dart';

//0xFFDFB6B2
var KLightScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF5561f5),
);
ThemeData LightTheme = ThemeData().copyWith(
  colorScheme: KLightScheme,
);

//0xFF2b124c
var KDarkScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF2b124c),
  brightness: Brightness.dark,
);
ThemeData DarkTheme = ThemeData.dark().copyWith(
  colorScheme: KDarkScheme,
);
