import 'dart:convert';

import 'package:flutter_chat_app/src/constants/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  static SharedPreferences? prefs;

  initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveStringData(String key, String value) async {
    await prefs?.setString(key, value);
  }

  Future<void> removeStringData(String key) async {
    await prefs?.remove(key);
  }

  Future<String> getStringData(String key) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs?.getString(key) ?? '';
  }

  Future<String?> getTokenData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs?.getString(KeyStorage.user) ?? '';
    if (user == '') {
      return null;
    } else {
      return jsonDecode(user)['access_token'];
    }
  }
}
