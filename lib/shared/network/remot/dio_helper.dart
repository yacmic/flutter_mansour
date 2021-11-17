import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        headers: {
          'Content-Type': 'application/json',
          'lang': 'ar',
        },
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String language = 'ar',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': language,
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    String language = 'ar',
    String? token,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'lang': language,
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
