import 'package:shared_preferences/shared_preferences.dart';

class TLocalStorage {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save Data
  static Future<void> saveData(String key, dynamic value) async {
    if (value is String) await _prefs?.setString(key, value);
    if (value is bool) await _prefs?.setBool(key, value);
    if (value is int) await _prefs?.setInt(key, value);
    if (value is double) await _prefs?.setDouble(key, value);
    if (value is List<String>) await _prefs?.setStringList(key, value);
  }

  // Read Data
  static dynamic readData(String key) {
    return _prefs?.get(key);
  }

  // Remove Data
  static Future<void> removeData(String key) async {
    await _prefs?.remove(key);
  }

  // Clear All Data
  static Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
