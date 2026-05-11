

import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String tokenKey = 'access_token';
  static const String userKey = 'user_data';

  AuthLocalDataSource({required this.sharedPreferences});

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(tokenKey, token);
  }

  Future<void> saveUser(String userJson) async {
    await sharedPreferences.setString(userKey, userJson);
  }

  String? getToken() {
    return sharedPreferences.getString(tokenKey);
  }

  String? getUser() {
    return sharedPreferences.getString(userKey);
  }

  Future<void> clearAuthData() async {
    await sharedPreferences.remove(tokenKey);
    await sharedPreferences.remove(userKey);
  }

  bool hasToken() {
    return sharedPreferences.containsKey(tokenKey);
  }
}