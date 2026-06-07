import 'package:wheaterapp/data/datasource/weather_local_datasource.dart';
import 'package:wheaterapp/domain/entities/weather.dart';
import 'package:wheaterapp/domain/entities/weather_event.dart';

class FakeWeatherLocalDatasource implements WeatherLocalDatasource {
  Weather? cachedWeather;
  final Map<String, List<WeatherEvent>> cachedEventsByLocation = {};
  bool throwOnWeatherRead = false;
  bool throwOnEventsRead = false;

  @override
  Future<void> cacheWeather(Weather weather) async {
    cachedWeather = weather;
  }

  @override
  Weather? getCachedWeather(String city) {
    if (throwOnWeatherRead) {
      throw Exception('cache read error');
    }
    return cachedWeather;
  }

  @override
  Future<void> cacheEvents(
    String location,
    List<WeatherEvent> events,
  ) async {
    cachedEventsByLocation[location] = List<WeatherEvent>.from(events);
  }

  @override
  List<WeatherEvent> getCachedEvents(String location) {
    if (throwOnEventsRead) {
      throw Exception('cache read error');
    }
    return cachedEventsByLocation[location] ?? [];
  }
}
