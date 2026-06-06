import 'dart:convert';

import 'package:realm/realm.dart';
import 'package:wheaterapp/data/models/event_cache.dart';

import '../../domain/entities/weather.dart';
import '../../domain/entities/weather_event.dart';
import '../models/event_model.dart';
import '../models/weather_cache.dart';
import '../models/weather_model.dart';
import 'weather_local_datasource.dart';

class WeatherLocalDatasourceImpl
    implements WeatherLocalDatasource {

  final Realm realm;

  WeatherLocalDatasourceImpl(this.realm);

  @override
  Future<void> cacheWeather(Weather weather) async {
    final model = weather as WeatherModel;

    realm.write(() {
      realm.add(
        WeatherCache(
          model.city,
          jsonEncode(model.toJson()),
          DateTime.now(),
        ),
        update: true,
      );
    });
  }

  @override
  Weather? getCachedWeather(String city) {
    final cache = realm.find<WeatherCache>(city);

    if (cache == null) {
      return null;
    }

    final json =
    jsonDecode(cache.jsonData) as Map<String, dynamic>;

    return WeatherModel.fromCache(json);
  }

  @override
  Future<void> cacheEvents(
      String location,
      List<WeatherEvent> events,
      ) async {
    realm.write(() {
      for (final event in events) {
        realm.add(
          EventCache(
            event.id,
            event.type,
            event.title,
            event.description,
            event.dateTime,
            latitude: event.latitude,
            longitude: event.longitude,
          ),
          update: true,
        );
      }
    });
  }

  @override
  List<WeatherEvent> getCachedEvents(
      String location,
      ) {
    return realm
        .all<EventCache>()
        .map(
          (e) => EventModel(
        id: e.id,
        type: e.type,
        title: e.title,
        description: e.description,
        dateTime: e.dateTime,
        latitude: e.latitude,
        longitude: e.longitude,
      ),
    )
        .toList();
  }
}