  
import 'package:dio/dio.dart';
import 'package:nadi_user_app/preferences/preferences.dart';

//https://nadi-buhrain-render.onrender.com/api/
class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.29.129:8080/api",
      connectTimeout: const Duration(seconds: 85),
      receiveTimeout: const Duration(seconds: 85),
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await AppPreferences.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
}


// onRequest -Runs before every API
// options.headers[...] -  Adds header automatically 
//https://nadi-buhrain-render.onrender.com/uploads/

class ImageBaseUrl {
  static const baseUrl = "http://192.168.29.129:8080/uploads";
}

//https://nadi-buhrain-render.onrender.com
class ImageAssetUrl{
    static const baseUrl = "http://192.168.29.129:8080";
}
