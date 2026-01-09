import 'package:dio/dio.dart';
import 'package:nadi_user_app/core/network/dio_client.dart';
import 'package:nadi_user_app/core/utils/logger.dart';

class PointsRequest {
  final _dio = DioClient.dio;
  Future<Map<String, dynamic>> sendtofriend({
    required String mobileNumber,
    required String points,
  }) async {
    try {
      final response = await _dio.post(
        "points/requestToFamily",
        data: {"mobileNumber": mobileNumber, "points": points},
      );
      AppLogger.warn("PointsRequest ${response.data}");
      return response.data;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;

      AppLogger.error("PointsRequest ERROR | status=$status | data=$data");

      final message = data is Map
          ? data['message'] ?? "Something went wrong"
          : "Network error";

      throw message;
    }
  }
}
