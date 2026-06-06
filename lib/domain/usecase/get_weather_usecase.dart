import 'package:dartz/dartz.dart';

import 'package:wheaterapp/core/exception/network_exception.dart';

import '../../data/repositories/weather_repository.dart';
import '../entities/weather.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<Either<Failure, Weather>> call(String city) {
    return repository.getLast5Days(city);
  }
}