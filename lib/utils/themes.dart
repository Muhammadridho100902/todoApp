import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xff4e5ae8);
const Color yellorClr = Color(0xffffb746);
const Color pinkClr = Color(0xffff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGryClr = Color(0xff121212);
const Color darkHeaderClr = Color(0xff424242); 


class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    // primaryColor: bluishClr,
    primaryColor: Colors.white,
    brightness: Brightness.light
  );

  static final dark = ThemeData(
    backgroundColor: darkGryClr,
    primaryColor: darkGryClr,
    brightness: Brightness.dark
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey
    )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black
    )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.white : Colors.black
    )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[800]
    )
  );
}

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key)?? false;
  ThemeMode get theme => _loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;

  void switchTheme(){
    Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}

