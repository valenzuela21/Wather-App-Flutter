import '../../domain/entities/weather.dart';
import '../../domain/entities/weather_event.dart';

abstract class WeatherLocalDatasource {
  Future<void> cacheWeather(Weather weather);

  Weather? getCachedWeather(String city);

  Future<void> cacheEvents(
      String location,
      List<WeatherEvent> events,
      );

  List<WeatherEvent> getCachedEvents(
      String location,
      );
}