  
import 'package:dio/dio.dart';
import 'package:nadi_user_app/preferences/preferences.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://nadi-buhrain-render-site.onrender.com/api/",
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
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
//http://192.168.29.129:8080/uploads/

class ImageBaseUrl {
  static const baseUrl = "https://nadi-buhrain-render-site.onrender.com/uploads";
}
//https://nadi-buhrain-render.onrender.com
class ImageAssetUrl{
    static const baseUrl = "https://nadi-buhrain-render-site.onrender.com";
}
 