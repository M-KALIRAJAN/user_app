
import 'package:mannai_user_app/core/network/dio_client.dart';
import 'package:mannai_user_app/core/utils/logger.dart';

class HomeViewService {
      final  _dio = DioClient.dio;
  // Service List API
Future<List<Map<String, dynamic>>> servicelists() async {
  try {
    final response = await _dio.get("service");

    return List<Map<String, dynamic>>.from(response.data["data"]);
  } catch (e) {
    AppLogger.error("servicelist Api: $e");
    return []; 
  }
}

}