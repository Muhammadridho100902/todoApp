import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const Color bluishClr = Color(0xff4e5ae8);
const Color yellorClr = Color(0xffffb746);
const Color pinkClr = Color(0xffff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGryClr = Color(0xff121212);
const Color darkHeaderClr = Color(0xff424242); 


class Themes {
  static final light = ThemeData(
    primaryColor: bluishClr,
    brightness: Brightness.light
  );

  static final dark = ThemeData(
    primaryColor: darkGryClr,
    brightness: Brightness.dark
  );
}

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key)?? false;
  ThemeMode get Theme => _loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;

  void switchTheme(){
    Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}

