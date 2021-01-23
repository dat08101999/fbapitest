import 'package:dio/dio.dart';
import 'package:fbtestapi/DioHelper/DioHelper.dart';
class FaceBookHelper{

 getInfo(id,token,String fields)
  {
     return DioHelpers.get(
         'https://graph.facebook.com/${id}?access_token=${token}',
         {
           'fields':'${fields}',
           'transport':'cors'
         },
         Options());
  }
  static replace(s)
  {
    return s.toString().replaceAll('"', '');
  }
}