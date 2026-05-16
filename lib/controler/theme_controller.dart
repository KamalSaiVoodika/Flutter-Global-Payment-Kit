import 'dart:developer';
import 'package:mystarter/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../main.dart';

class ThemeController extends GetxController {
  ThemeController() {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    prefs.setBool(theme, _darkTheme);
    update();
  }

  void _loadCurrentTheme() async {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    log('is Dark ${Get.isDarkMode} ${ThemeData.dark()} mode $isDarkMode');
    _darkTheme = prefs.getBool(theme) ?? isDarkMode ? true : false;
    log(_darkTheme.toString());
    update();
  }

  void updateTheme(bool isDark) {
    _darkTheme = isDark;
    prefs.setBool(theme, isDark);
    update();
  }
}
