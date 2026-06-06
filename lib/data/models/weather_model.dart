import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.city,
    required super.currentTemp,
    required super.condition,
    required super.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final days = json['days'] as List;

    final currentConditions =
    json['currentConditions'] as Map<String, dynamic>?;

    return WeatherModel(
      city: json['resolvedAddress'] ?? '',
      currentTemp: currentConditions?['temp']?.toDouble() ??
          (days.first['temp'] ?? 0).toDouble(),
      condition: currentConditions?['conditions'] ??
          days.first['conditions'] ??
          '',
      forecast: days.take(5).map((e) {
        return ForecastDay(
          date: DateTime.parse(e['datetime']),
          tempMax: (e['tempmax'] ?? 0).toDouble(),
          tempMin: (e['tempmin'] ?? 0).toDouble(),
          conditions: e['conditions'] ?? '',
        );
      }).toList(),
    );
  }

  factory WeatherModel.fromCache(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'],
      currentTemp: json['currentTemp'].toDouble(),
      condition: json['condition'],
      forecast: (json['forecast'] as List)
          .map(
            (e) => ForecastDay(
          date: DateTime.parse(e['date']),
          tempMax: e['tempMax'].toDouble(),
          tempMin: e['tempMin'].toDouble(),
          conditions: e['conditions'],
        ),
      )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'currentTemp': currentTemp,
      'condition': condition,
      'forecast': forecast.map((e) {
        return {
          'date': e.date.toIso8601String(),
          'tempMax': e.tempMax,
          'tempMin': e.tempMin,
          'conditions': e.conditions,
        };
      }).toList(),
    };
  }
}