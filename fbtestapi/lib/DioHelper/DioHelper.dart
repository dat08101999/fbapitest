import 'package:dio/dio.dart';

class DioHelpers{

  static get(url,params,options)async
  {
    try{
      Response response= await Dio().get(url,queryParameters: params,options:options);
      return response.data;
    }catch(e,trace)
    {
      print(trace);
      return null;
    }
  }
  static post({url,prams,options}) async
  {
    try{
      Response response= await Dio().post(url,queryParameters: prams,options: options);
      return response.data;
    }catch(e,trace)
    {
      print(trace);
      return null;
    }
  }
}