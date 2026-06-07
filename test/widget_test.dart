import 'package:flutter_test/flutter_test.dart';
import 'package:wheaterapp/data/models/weather_model.dart';

import 'fixtures/weather_fixtures.dart';

void main() {
  test('WeatherModel.fromJson parsea la respuesta de la API', () {
    final model = WeatherModel.fromJson(sampleWeatherJson);

    expect(model.city, isNotEmpty);
    expect(model.forecast, isNotEmpty);
  });
}
