import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:wheaterapp/core/utils/helpers.dart';

import '../../core/constants/api_constants.dart';
import '../../core/exception/network_exception.dart';
import '../../core/network/dio_client.dart';
import '../../core/network/network_info.dart';
import '../../core/network/network_info_impl.dart';
import '../models/event_model.dart';
import '../models/weather_model.dart';

class WeatherRemoteDatasource {

  late final Dio dio;
  late final NetworkInfo networkInfo;

  WeatherRemoteDatasource({
    NetworkInfo? networkInfo,
  }) {
    dio = DioClient.create();
    this.networkInfo = networkInfo ?? NetworkInfoImpl(Connectivity());
  }

  Future<List<EventModel>> getEvents(String location) async {
    if (!await networkInfo.isConnected) {
      throw NetworkException();
    }

    try {
      final response = await dio.get(
        '${ApiConstants.timelineEndpoint}/$location',
        queryParameters: {
          'unitGroup': 'metric',
          'include': 'events',
          'lang': 'es',
          'key': ApiConstants.apiKey,
          'contentType': 'json',
        },
      );

      final List events = response.data['days'] ?? [];

      return events
          .map((event) => EventModel.fromJson(event))
          .toList();
    }on DioException catch (e) {
      Helpers.systemPrint('STATUS: ${e.response?.statusCode}');
      Helpers.systemPrint('DATA: ${e.response?.data}');
      rethrow;
    }
  }

  Future<WeatherModel> getLast5Days(String city) async {
    if (!await networkInfo.isConnected) {
      throw NetworkException();
    }

    try {
      final encodedCity = Uri.encodeComponent(city);
      final response = await dio.get(
        '${ApiConstants.timelineEndpoint}/$encodedCity/last5days',
        queryParameters: {
          'unitGroup': 'metric',
          'lang': 'es',
          'key': ApiConstants.apiKey,
          'contentType': 'json',
        },
      );

      final weather = WeatherModel.fromJson(response.data);

      return weather;
    } on DioException catch (e) {
      Helpers.systemPrint('STATUS: ${e.response?.statusCode}');
      Helpers.systemPrint('DATA: ${e.response?.data}');
      rethrow;
    }
  }
}