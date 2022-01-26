import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static setInt(String key, int? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value != null) {
      prefs.setInt(key, value);
    }
  }

  static Future<int> getInt(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var value = prefs.getInt(key);
      if (value != null) {
        return value;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  static setBoolean(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool?> getBoolean(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
