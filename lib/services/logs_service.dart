import 'package:dio/dio.dart';
import 'package:nadi_user_app/core/network/dio_client.dart';
import 'package:nadi_user_app/core/utils/logger.dart';

class LogsService {
  final _dio = DioClient.dio;

  Future<List<Map<String, dynamic>>?> UserLogs() async {
    try {
      final response = await _dio.post("user-log");
      return List<Map<String, dynamic>>.from(response.data['data']);
    } on DioException catch (e) {
      AppLogger.error("UserlogErrorstatusCode : ${e.response?.statusCode}");
      AppLogger.error("UserlogError : ${e.response?.data}");
    }
  }
}
