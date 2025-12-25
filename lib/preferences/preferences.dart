import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // --- KEYS ---
  static const String _tokenKey = "auth_token";
  static const String _loginKey = "is_logged_in";
  static const String _userIdKey = "user_id";
  static const String _aboutSeenKey = "about_seen";
  static const String _accounttypekey = "account_type";
  static const String _namekey = "name";
 static const String _phonenumberkey = "phonenumber";



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
// --- Phone Number ---- 

static Future<void> savephonenumber(String value)async{
  final prefs =await SharedPreferences.getInstance();
  await prefs.setString(_phonenumberkey, value);
}

static Future<String?> getphonenumber() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_phonenumberkey);
}
  // ---- ACCOUNT TYPE ----

 // save account type 
 static Future<void>saveAccountType(String accountType) async{
   final prefs = await SharedPreferences.getInstance();
   await prefs.setString(_accounttypekey, accountType);
 }

 // get accounttype
 static Future<String?> getaccounttype() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_accounttypekey);
 }




// ---- User Name --
  static Future<void> saveusername(String name)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_namekey, name);
  }

  static Future<String?> getusername()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_namekey);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
