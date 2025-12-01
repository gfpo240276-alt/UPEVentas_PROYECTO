import 'package:flutter/material.dart';

class AppThemes {
  static Color mainColor = const Color.fromRGBO(234, 172, 139, 1);
  static Color secondaryColor = const Color.fromRGBO(234, 139, 141, 1);
  static Color tertiaryColor = const Color.fromRGBO(255, 208, 208, 1);
  static Color fourthColor = const Color.fromRGBO(211, 47, 47, 1);
  static Color fifthColor = const Color.fromRGBO(245, 124, 0, 1);

  static final temaClaro = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: mainColor, error: fourthColor),
    appBarTheme: AppBarTheme(
      backgroundColor: mainColor,
      shadowColor: tertiaryColor,
      elevation: 1,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(
        fontFamily: 'MainFont',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        fontSize: 20,
      ),
    ),
  );
}
