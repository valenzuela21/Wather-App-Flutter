import 'package:dartz/dartz.dart';

import 'package:wheaterapp/core/exception/network_exception.dart';

import '../../data/repositories/weather_repository.dart';
import '../entities/weather_event.dart';

class GetEventsUseCase {
  final WeatherRepository repository;

  GetEventsUseCase(this.repository);

  Future<Either<Failure, List<WeatherEvent>>> call(String location) {
    return repository.getEvents(location);
  }
}