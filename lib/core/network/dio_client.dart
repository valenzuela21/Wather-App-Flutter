import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wheaterapp/core/constants/api_constants.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "${ApiConstants.baseUrl}/VisualCrossingWebServices/rest/services",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
     PrettyDioLogger(
       request: true,
       requestBody: true,
       responseBody: true,
       responseHeader: true,
       error: true,
       logPrint: (obj) => debugPrint(obj.toString())
     )
    );

    return dio;
  }
}