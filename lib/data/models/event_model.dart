import '../../domain/entities/weather_event.dart';
import 'event_cache.dart';

class EventModel extends WeatherEvent {
  EventModel({
    required super.id,
    required super.type,
    required super.title,
    required super.description,
    required super.dateTime,
    super.latitude,
    super.longitude,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['datetime']?.toString() ?? '',
      type: json['conditions']?.toString() ?? '',
      title: json['conditions']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      dateTime: DateTime.parse(json['datetime']),
      latitude: null,
      longitude: null,
    );
  }

  factory EventModel.fromCache(EventCache cache) {
    return EventModel(
      id: cache.id,
      type: cache.type,
      title: cache.title,
      description: cache.description,
      dateTime: cache.dateTime,
      latitude: cache.latitude,
      longitude: cache.longitude,
    );
  }

  EventCache toCache() {
    return EventCache(
      id,
      type,
      title,
      description,
      dateTime,
      latitude: latitude,
      longitude: longitude,
    );
  }
}