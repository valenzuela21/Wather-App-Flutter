import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:wheaterapp/core/exception/network_exception.dart';
import 'package:wheaterapp/domain/usecase/get_events_usecase.dart';
import 'package:wheaterapp/domain/usecase/get_weather_usecase.dart';
import 'package:wheaterapp/presentation/controllers/weather_controller.dart';

import '../../fakes/fake_weather_repository.dart';
import '../../fixtures/weather_fixtures.dart';

void main() {
  late FakeWeatherRepository repository;
  late WeatherController controller;

  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(() {
    Get.testMode = true;
    repository = FakeWeatherRepository();
    controller = WeatherController(
      GetWeatherUseCase(repository),
      GetEventsUseCase(repository),
    );
  });

  tearDown(() {
    Get.reset();
  });

  group('WeatherController.loadWeather', () {
    test('actualiza weather cuando el caso de uso tiene éxito', () async {
      final weather = sampleWeatherEntity();
      repository.weatherResult = Right(weather);

      await controller.loadWeather(sampleCity);

      expect(controller.weather.value, weather);
      expect(controller.loading.value, isFalse);
    });

    test('limpia weather cuando ocurre un fallo de red', () async {
      controller.weather.value = sampleWeatherEntity();
      repository.weatherResult = Left(NetworkFailure());

      await controller.loadWeather(sampleCity);

      expect(controller.weather.value, isNull);
      expect(controller.loading.value, isFalse);
    });
  });

  group('WeatherController.loadEvents', () {
    test('actualiza events cuando el caso de uso tiene éxito', () async {
      final events = [sampleWeatherEvent()];
      repository.eventsResult = Right(events);

      await controller.loadEvents(sampleCity);

      expect(controller.events, events);
      expect(controller.loading.value, isFalse);
    });

    test('limpia events cuando ocurre un fallo de red', () async {
      controller.events.add(sampleWeatherEvent());
      repository.eventsResult = Left(NetworkFailure());

      await controller.loadEvents(sampleCity);

      expect(controller.events, isEmpty);
      expect(controller.loading.value, isFalse);
    });
  });
}
