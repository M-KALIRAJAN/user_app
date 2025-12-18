
import 'package:mannai_user_app/core/network/dio_client.dart';
import 'package:mannai_user_app/core/utils/logger.dart';

class RequestSerivices{
     final _dio = DioClient.dio;

     Future<List<Map<String ,dynamic>>?> IssuseList()async{
       try{
        final response = await _dio.get("issue");
        final  dataList =  List<Map<String,dynamic>>.from(response.data["data"]);
           return dataList;
       }catch(e){
        AppLogger.error("IssuseList $e");
       }
     }
}