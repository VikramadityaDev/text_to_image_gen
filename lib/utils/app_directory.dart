import 'package:shared_preferences/shared_preferences.dart';

class PathSharedPreferences {
  static const String _keyPath = 'path';

  static Future<void> setPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPath, path);
  }

  static Future<String?> getPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPath);
  }
}
