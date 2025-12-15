import 'dart:convert';

import 'package:mannai_user_app/core/network/dio_client.dart';
import 'package:mannai_user_app/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _dio = DioClient.dio;

  // Fetch account type
  Future<List<Map<String?, dynamic>>?> acountype() async {
    try {
      final response = await _dio.get("account-type");
      if (response.statusCode == 200 && response.data != null) {
        final dataList = List<Map<String, dynamic>>.from(response.data["data"]);
        AppLogger.debug("dataList $dataList");
        final prefs = await SharedPreferences.getInstance();
        for (var account in dataList) {
          if (account["type"] == "FA") {
            await prefs.setString("family_id", account["_id"]);

            await prefs.setString("family_name", account["name"]);
          } else if (account["type"] == "IA") {
            await prefs.setString("individual_id", account["_id"]);
            await prefs.setString("individual_name", account["name"]);
          }
        }
        return dataList;
      }
    } catch (e, st) {
      AppLogger.error("Account type API error: $e\n$st");
      return null;
    }
  }

  //selectIndividualAccount
  Future<bool> selectIndividualAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accountTypeId = prefs.getString("individual_id");
      AppLogger.warn("individualId $accountTypeId");

      if (accountTypeId == null) return false;

      final response = await _dio.post(
        "user-account/",
        data: {"accountTypeId": accountTypeId},
      );

      AppLogger.debug("selectIndividualAccount response: ${response.data}");

      // Extract userId from response and store in SharedPreferences
      final userId = response.data["userId"].toString();
      if (userId != null) {
        await prefs.setString("userId", userId);
        AppLogger.warn("userId saved in SharedPreferences: $userId");
      } 

      return true;
    } catch (e, st) {
      AppLogger.error("Account type API error: $e\n$st");
      return false;
    }
  }

  // Sign Up Basic INFO
  Future<Map<String?, dynamic>> basicInfo({
    required String fullName,
    required String mobileNumber,
    required String email,
    required String password,
    required String gender,
     required String userId
  }) async {
    try {
      final response = await _dio.post(
        "user-account/basic-info",
        data: {
          "userId":userId,
          "full_name": fullName,
          "mobile": mobileNumber,
          "email": email,
          "password": password,
          "gender": gender,
        },
      );
         AppLogger.success(response.data.toString());
      return response.data;
    } catch (e) {
      AppLogger.error("Basic Info ${e}");
      throw Exception("Basic info failed");
    }
  }

Future<List<Map<String, dynamic>>> selectblock() async {
  try {
    final response = await _dio.get("block");

    // Ensure proper typing
    final List<dynamic> rawData = response.data["data"];
    final blockData = rawData.map((e) => Map<String, dynamic>.from(e)).toList();

    // Print entire JSON nicely
    final prettyJson = const JsonEncoder.withIndent('  ').convert(blockData);
    print("========= Roads & Blocks =========");
    print(prettyJson);
  

    

    return blockData;
  } catch (e) {
    AppLogger.error("SELECTBLOCK Error: $e");
    return [];
  }
}


  //Sign Up Adress Deatails
//   Future<Map<String,dynamic>> accountdetails({
//     required String addressType,
//     required String city,
//     required String building,
//     required String aptNo
// ,
//   }) async{

//   }


}
