import 'package:flutter_test/flutter_test.dart';
import 'package:wheaterapp/data/models/weather_model.dart';
import 'package:wheaterapp/domain/entities/weather.dart';

import '../../fixtures/weather_fixtures.dart';

void main() {
  group('WeatherModel', () {
    test('fromJson mapea ciudad, temperatura actual y pronóstico de 5 días', () {
      final model = WeatherModel.fromJson(sampleWeatherJson);

      expect(model.city, 'Bogota, Colombia');
      expect(model.currentTemp, 22.5);
      expect(model.condition, 'Parcialmente nublado');
      expect(model.forecast, hasLength(5));
      expect(model.forecast.first.conditions, 'Parcialmente nublado');
    });

    test('fromJson usa el primer día cuando no hay currentConditions', () {
      final json = Map<String, dynamic>.from(sampleWeatherJson)
        ..remove('currentConditions');
      final days = List<Map<String, dynamic>>.from(json['days'] as List);
      days[0] = Map<String, dynamic>.from(days[0])..['temp'] = 25.0;
      json['days'] = days;

      final model = WeatherModel.fromJson(json);

      expect(model.currentTemp, 25.0);
      expect(model.condition, 'Parcialmente nublado');
    });

    test('toJson y fromCache conservan los datos del clima', () {
      final original = sampleWeatherModel();
      final restored = WeatherModel.fromCache(original.toJson());

      expect(restored.city, original.city);
      expect(restored.currentTemp, original.currentTemp);
      expect(restored.condition, original.condition);
      expect(restored.forecast.length, original.forecast.length);
      expect(
        restored.forecast.first.date,
        original.forecast.first.date,
      );
    });

    test('toJson serializa el pronóstico con fechas ISO8601', () {
      final json = sampleWeatherModel().toJson();
      final forecast = json['forecast'] as List;

      expect(forecast.first['date'], isA<String>());
      expect(forecast.first['tempMax'], 25.0);
      expect(forecast.first['tempMin'], 18.0);
    });
  });
}
