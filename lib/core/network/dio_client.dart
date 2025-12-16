  
import 'package:dio/dio.dart';

class DioClient {
  static final  dio = Dio(
    BaseOptions(
      baseUrl: "https://nadi-buhrain-render.onrender.com/api/",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  // ..interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (options, handler) async {
  //         final prefs = await SharedPreferences.getInstance();
  //         final token = prefs.getString('auth_token');

  //         if (token != null && token.isNotEmpty) {
  //           options.headers['Authorization'] = 'Bearer $token';
  //         }
  //          return handler.next(options);
  //       }
       
  //     )
  // );
}

// onRequest -Runs before every API
// options.headers[...] -  Adds header automatically 
class ImageBaseUrl {
  static const baseUrl = "https://nadi-buhrain-render.onrender.com/uploads/";
}
