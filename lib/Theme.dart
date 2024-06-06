import 'package:flutter/material.dart';

class apptheme {
  static Color primarycolor = Color(0xffF86676);
  static Color Containerbackgroundcolorlight = Color(0xffFFFFFF);
  static Color backgroundcolorlight = Color(0xffF9F9F9);
  static Color backgroundcolordark = Color(0xFF201C1D);
  static Color Containerbackgroundcolordark = Color(0xff4D4948);
  static Color unselectedcolor = Color(0xffA6A5A5);
  static Color fontcolorlight = Color(0xff151011);
  static Color fontcolordark = Color(0xffffffff);

  static ThemeData lighttheme = ThemeData(
    primaryColor: primarycolor,
    scaffoldBackgroundColor: backgroundcolorlight,
    appBarTheme: AppBarTheme(
      backgroundColor: Containerbackgroundcolorlight,
      titleTextStyle: TextStyle(color: fontcolorlight),
    ),
    cardColor: fontcolorlight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Containerbackgroundcolorlight,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primarycolor),
        textStyle: MaterialStateProperty.all(TextStyle(color: Colors.black)),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: fontcolorlight),
      bodyText2: TextStyle(color: fontcolorlight),
      button: TextStyle(color: Colors.black),
    ),
  );

  static ThemeData darktheme = ThemeData(
    primaryColor: primarycolor,
    scaffoldBackgroundColor: backgroundcolordark,
    appBarTheme: AppBarTheme(
      backgroundColor: Containerbackgroundcolordark,
      titleTextStyle: TextStyle(color: fontcolordark),
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
    textTheme: TextTheme(
      bodyText1: TextStyle(color: fontcolordark),
      bodyText2: TextStyle(color: fontcolordark),
      button: TextStyle(color: Colors.white),
    ),
  );
}
