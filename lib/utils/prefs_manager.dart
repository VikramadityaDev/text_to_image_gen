import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  saveThemeIndex(int themeIndex) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("themeIndex", themeIndex);
  }

  Future<int> getThemeIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt("themeIndex");
    if (themeIndex != null) {
      return themeIndex;
    } else
      return 0;
  }

  saveAccentIndex(int accentIndex) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("accentIndex", accentIndex);
  }

  Future<int> getAccentIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accentIndex = prefs.getInt("accentIndex");
    if (accentIndex != null) {
      return accentIndex;
    } else
      return 0;
  }
}