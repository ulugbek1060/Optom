import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;
  static const String tokenKey = 'access_token';
  static const String userKey = 'user_data';

  AuthLocalDataSource(this._sharedPreferences);

  Future<void> saveToken(String token) async {
    await _sharedPreferences.setString(tokenKey, token);
  }

  Future<void> saveUser(String userJson) async {
    await _sharedPreferences.setString(userKey, userJson);
  }

  String? getToken() {
    return _sharedPreferences.getString(tokenKey);
  }

  String? getUser() {
    return _sharedPreferences.getString(userKey);
  }

  Future<void> clearAuthData() async {
    await _sharedPreferences.remove(tokenKey);
    await _sharedPreferences.remove(userKey);
  }

  bool hasToken() {
    return _sharedPreferences.containsKey(tokenKey);
  }
}
