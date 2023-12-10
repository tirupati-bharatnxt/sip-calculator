import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white54,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black38),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black54,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );

  static const Color lightBG = Colors.white54;
  static const Color darkBG = Colors.black54;


}
