import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:wheaterapp/core/exception/network_exception.dart';
import 'package:wheaterapp/data/repositories/weather_repository.dart';
import 'package:wheaterapp/domain/entities/weather.dart';
import 'package:wheaterapp/domain/entities/weather_event.dart';

class FakeWeatherRepository implements WeatherRepository {
  Either<Failure, Weather>? weatherResult;
  Either<Failure, List<WeatherEvent>>? eventsResult;
  Completer<Either<Failure, Weather>>? pendingWeather;
  Completer<Either<Failure, List<WeatherEvent>>>? pendingEvents;
  String? lastWeatherCity;
  String? lastEventsLocation;

  @override
  Future<Either<Failure, List<WeatherEvent>>> getEvents(String location) async {
    lastEventsLocation = location;
    if (pendingEvents != null) {
      return pendingEvents!.future;
    }
    return eventsResult ?? const Right([]);
  }

  @override
  Future<Either<Failure, Weather>> getLast5Days(String city) async {
    lastWeatherCity = city;
    if (pendingWeather != null) {
      return pendingWeather!.future;
    }
    return weatherResult ?? Left(UnknownFailure());
  }
}
