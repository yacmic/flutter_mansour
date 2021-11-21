import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String language = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': language,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.get(
      url,
      queryParameters: query ?? null,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    String language = 'en',
    String? token,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'lang': language,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.post(
      url,
      queryParameters: query ?? null,
      data: data,
    );
  }
}
