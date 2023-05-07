import 'package:shared_preferences/shared_preferences.dart';

class ThemeSharedPreferences {
  static const String _keyTheme = 'theme';
  static const String _keyMode = 'mode';

  static Future<void> setThemeName(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyTheme, theme);
  }

  static Future<String?> getThemeName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyTheme);
  }

  static Future<void> setModeName(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyMode, mode.toLowerCase());
  }

  static Future<String?> getModeName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyMode);
  }
}
