import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // ================== KEYS ==================
  static const String _tokenKey = "auth_token";
  static const String _loginKey = "is_logged_in";
  static const String _userIdKey = "user_id";

  static const String _aboutSeenKey = "about_seen";



  // ================== TOKEN ==================
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? '';
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // ================== LOGIN FLAG ==================
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }

  // ================== ABOUT SCREEN ==================
  static Future<void> setAboutSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_aboutSeenKey, value);
  }

  static Future<bool> hasSeenAbout() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_aboutSeenKey) ?? false;
  }

  // ================== USER ID ==================
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }





  // ================== LOGOUT / CLEAR ==================
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
