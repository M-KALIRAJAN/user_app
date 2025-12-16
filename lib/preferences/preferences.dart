
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {

  // keys
  static const String _tokenkey = "auth_token";
  static const  String _loginkey = "is_logged_in";
  static const String _userIdKey = "user_id";

  //----TOKEN---

  // Save token
  static Future<void> saveToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenkey, token);
  }
  // Get token
  static Future<String>getToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenkey) ??  '';
  }
  // Remove token 
    static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenkey);
  }

  // --- LOGIN FLAG --- 
   
   // * App Open
          // Login flag = true na
           // direct Home 
 // *App restart after kill 
         //  App close pannirukaar
         // Reopen pannaar
  //LoginFlag  = Door open / close status  
  //


  // Set login status
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginkey, value);
  } 
  // Check login status
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginkey) ?? false;
  }

   // --- USER ID --- 
   
   // saveUserId
     static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }
  //getUserId
   static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }
  

  // --- LOGOUT (CLEAN EVERYTHING) ---
   static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
    
}