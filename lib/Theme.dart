import 'package:flutter/material.dart';

class apptheme {
  static Color primarycolor = Color(0xffF86676);
  static Color Containerbackgroundcolorlight = Color(0xffFFFFFFF);
  static Color backgroundcolorlight = Color(0xffF9F9F9);
  static Color backgroundcolordark = Color(0xFF201C1D);
  static Color Containerbackgroundcolordark = Color(0xff4D4948);
  static Color unselectedcolor = Color(0xffA6A5A5);
  static Color fontcolorligt = Color(0xff151011);
  static Color fontcolordark = Color(0xffffffff);

  static ThemeData lighttheme = ThemeData(
    scaffoldBackgroundColor: backgroundcolorlight,
    appBarTheme: AppBarTheme(
      backgroundColor: Containerbackgroundcolorlight,
    ),
    cardColor: fontcolorligt,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Containerbackgroundcolorlight,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Containerbackgroundcolorlight),
        textStyle: MaterialStateProperty.all(TextStyle(color: Colors.black)),
      ),
    ),
  );

  static ThemeData darktheme = ThemeData(
    scaffoldBackgroundColor: backgroundcolordark,
    appBarTheme: AppBarTheme(
      backgroundColor: Containerbackgroundcolordark,
    ),
    cardColor: fontcolordark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Containerbackgroundcolordark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primarycolor),
        textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
      ),
    ),
  );
}
