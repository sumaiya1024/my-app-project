import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static const String _themePrefKey = 'app_theme_dark_mode';

  /// ValueNotifier holding the current ThemeMode (light or dark).
  static final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  /// Returns true if currently in dark mode.
  static bool get isDarkMode => themeModeNotifier.value == ThemeMode.dark;

  /// Initializes the stored theme preference from SharedPreferences.
  static Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_themePrefKey) ?? false;
      themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    } catch (_) {
      themeModeNotifier.value = ThemeMode.light;
    }
  }

  /// Sets dark mode state and saves it in SharedPreferences.
  static Future<void> setDarkMode(bool isDark) async {
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themePrefKey, isDark);
    } catch (_) {}
  }

  /// Toggles between light and dark mode.
  static Future<void> toggleTheme() async {
    await setDarkMode(!isDarkMode);
  }
}
