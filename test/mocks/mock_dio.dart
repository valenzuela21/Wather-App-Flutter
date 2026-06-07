import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

Response<dynamic> dioResponse(Map<String, dynamic> data, {String path = '/'}) {
  return Response(
    requestOptions: RequestOptions(path: path),
    data: data,
    statusCode: 200,
  );
}
