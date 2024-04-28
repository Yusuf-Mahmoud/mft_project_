import 'package:flutter/material.dart';

class settingsprovider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languagecode = 'en';

  void changetheme(ThemeMode selectedtheme) {
    themeMode = selectedtheme;
    notifyListeners();
  }

  void changelanguage(String selectedlanguage) {
    languagecode = selectedlanguage;
    notifyListeners();
  }
}
