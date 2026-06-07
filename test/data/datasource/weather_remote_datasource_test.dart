import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheaterapp/core/constants/api_constants.dart';
import 'package:wheaterapp/core/exception/network_exception.dart';
import 'package:wheaterapp/data/datasource/weather_remote_datasource.dart';

import '../../fixtures/weather_fixtures.dart';
import '../../mocks/mock_dio.dart';
import '../../mocks/mock_network_info.dart';

void main() {
  late MockDio mockDio;
  late MockNetworkInfo mockNetworkInfo;
  late WeatherRemoteDatasource datasource;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
  });

  setUp(() {
    mockDio = MockDio();
    mockNetworkInfo = MockNetworkInfo();
    datasource = WeatherRemoteDatasource(
      networkInfo: mockNetworkInfo,
      dio: mockDio,
    );
  });

  group('WeatherRemoteDatasource.getLast5Days', () {
    test('devuelve WeatherModel cuando hay conexión y la API responde', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => dioResponse(sampleWeatherJson, path: '/last5days'),
      );

      final result = await datasource.getLast5Days('Bogotá');

      expect(result.city, 'Bogota, Colombia');
      expect(result.currentTemp, 22.5);
      expect(result.forecast, hasLength(5));

      final captured = verify(
        () => mockDio.get<dynamic>(
          captureAny(),
          queryParameters: captureAny(named: 'queryParameters'),
        ),
      ).captured;

      expect(
        captured.first,
        '${ApiConstants.timelineEndpoint}/${Uri.encodeComponent('Bogotá')}/last5days',
      );
      expect(captured.last['unitGroup'], 'metric');
      expect(captured.last['key'], ApiConstants.apiKey);
    });

    test('lanza NetworkException cuando no hay conexión', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      expect(
        () => datasource.getLast5Days('Bogotá'),
        throwsA(isA<NetworkException>()),
      );
      verifyNever(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      );
    });

    test('propaga DioException cuando la API falla', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/error'),
          response: Response(
            requestOptions: RequestOptions(path: '/error'),
            statusCode: 500,
          ),
        ),
      );

      expect(
        () => datasource.getLast5Days('Bogotá'),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('WeatherRemoteDatasource.getEvents', () {
    test('devuelve lista de eventos cuando hay conexión y la API responde', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => dioResponse(sampleEventsApiResponse),
      );

      final result = await datasource.getEvents('Bogotá');

      expect(result, hasLength(2));
      expect(result.first.title, 'Tormenta');
      expect(result.last.title, 'Lluvia');

      final captured = verify(
        () => mockDio.get<dynamic>(
          captureAny(),
          queryParameters: captureAny(named: 'queryParameters'),
        ),
      ).captured;

      expect(captured.first, '${ApiConstants.timelineEndpoint}/Bogotá');
      expect(captured.last['include'], 'events');
    });

    test('lanza NetworkException cuando no hay conexión', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      expect(
        () => datasource.getEvents('Bogotá'),
        throwsA(isA<NetworkException>()),
      );
    });

    test('devuelve lista vacía cuando la API no incluye días', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockDio.get<dynamic>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => dioResponse({}));

      final result = await datasource.getEvents('Bogotá');

      expect(result, isEmpty);
    });
  });
}
