import 'package:dio/dio.dart';
import 'api_interceptors.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);
    
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: 'https://talabat639.runasp.net',
          connectTimeout: timeOut,
          receiveTimeout: timeOut,
        ),
      );
      
      
      _dio!.interceptors.add(ApiInterceptors());
      _dio!.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
      
      return _dio!;
    } else {
      return _dio!;
    }
  }
}