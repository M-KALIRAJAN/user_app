
import 'package:mannai_user_app/core/network/dio_client.dart';
import 'package:mannai_user_app/core/utils/logger.dart';

class HomeViewService {
      final  _dio = DioClient.dio;
  // Service List API
  Future<Map<String, dynamic>?> servicelists() async {
    try {
      final response = await _dio.get("service");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        AppLogger.error("Service API failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      AppLogger.error("servicelist Api: $e");
      return null;
    }
  }
}