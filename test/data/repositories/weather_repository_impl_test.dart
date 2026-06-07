import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wheaterapp/core/exception/network_exception.dart';
import 'package:wheaterapp/data/repositories/weather_repository_impl.dart';

import '../../fakes/fake_connection_services.dart';
import '../../fakes/fake_weather_local_datasource.dart';
import '../../fakes/fake_weather_remote_datasource.dart';
import '../../fixtures/weather_fixtures.dart';

void main() {
  late FakeWeatherRemoteDatasource remote;
  late FakeWeatherLocalDatasource local;
  late FakeConnectionServices connectivity;
  late WeatherRepositoryImpl repository;

  setUp(() {
    remote = FakeWeatherRemoteDatasource();
    local = FakeWeatherLocalDatasource();
    connectivity = FakeConnectionServices(connected: true);
    repository = WeatherRepositoryImpl(remote, local, connectivity);
  });

  group('WeatherRepositoryImpl.getLast5Days', () {
    test('con internet obtiene datos remotos y los guarda en caché', () async {
      final weather = sampleWeatherModel();
      remote.weatherResult = weather;

      final result = await repository.getLast5Days(sampleCity);

      expect(result, Right(weather));
      expect(local.cachedWeather, weather);
    });

    test('sin internet devuelve clima en caché si existe', () async {
      connectivity.setConnected(false);
      final weather = sampleWeatherEntity();
      local.cachedWeather = weather;

      final result = await repository.getLast5Days(sampleCity);

      expect(result, Right(weather));
    });

    test('sin internet y sin caché devuelve NetworkFailure', () async {
      connectivity.setConnected(false);

      final result = await repository.getLast5Days(sampleCity);

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<NetworkFailure>());
    });

    test('con error de red remota devuelve NetworkFailure', () async {
      remote.errorToThrow = NetworkException();

      final result = await repository.getLast5Days(sampleCity);

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<NetworkFailure>());
    });

    test('con error inesperado devuelve UnknownFailure', () async {
      remote.errorToThrow = Exception('unexpected');

      final result = await repository.getLast5Days(sampleCity);

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<UnknownFailure>());
    });
  });

  group('WeatherRepositoryImpl.getEvents', () {
    test('con internet obtiene eventos y los guarda en caché', () async {
      final events = sampleEventModels();
      remote.eventsResult = events;

      final result = await repository.getEvents(sampleCity);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Se esperaba éxito'),
        (data) => expect(data, events),
      );
      expect(local.cachedEventsByLocation[sampleCity], events);
    });

    test('sin internet devuelve eventos en caché si existen', () async {
      connectivity.setConnected(false);
      final events = [sampleWeatherEvent()];
      await local.cacheEvents(sampleCity, events);

      final result = await repository.getEvents(sampleCity);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Se esperaba éxito'),
        (data) => expect(data, events),
      );
    });

    test('sin internet y sin caché devuelve NetworkFailure', () async {
      connectivity.setConnected(false);

      final result = await repository.getEvents(sampleCity);

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<NetworkFailure>());
    });

    test('con NetworkException remota usa caché si está disponible', () async {
      final events = [sampleWeatherEvent()];
      await local.cacheEvents(sampleCity, events);
      remote.errorToThrow = NetworkException();

      final result = await repository.getEvents(sampleCity);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Se esperaba éxito'),
        (data) => expect(data, events),
      );
    });

    test('con NetworkException remota sin caché devuelve NetworkFailure', () async {
      remote.errorToThrow = NetworkException();

      final result = await repository.getEvents(sampleCity);

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<NetworkFailure>());
    });
  });
}
