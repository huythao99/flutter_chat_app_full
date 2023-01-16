import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  static SharedPreferences? _instance;

  static initPreference() async {
    _instance ??= await SharedPreferences.getInstance();
  }

  static Future<void> saveStringData(String key, String value) async {
    await _instance?.setString(key, value);
  }

  static String getStringData(String key) {
    return _instance?.getString(key) ?? '';
  }
}
