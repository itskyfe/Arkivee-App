import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  ThemeMode get themeMode => isDark.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDark.value = !isDark.value;

    Get.changeThemeMode(themeMode);
  }

  /// RESET KE LIGHT MODE
  void resetTheme() {
    isDark.value = false;

    Get.changeThemeMode(ThemeMode.light);
  }
}
