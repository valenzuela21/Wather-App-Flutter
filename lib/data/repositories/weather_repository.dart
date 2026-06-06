import 'package:dartz/dartz.dart';
import '../../core/exception/network_exception.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/weather_event.dart';


abstract class WeatherRepository {
  Future<Either<Failure, List<WeatherEvent>>> getEvents(String location);

  Future<Either<Failure, Weather>> getLast5Days(String city);
}