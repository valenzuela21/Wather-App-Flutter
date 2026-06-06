import 'package:dartz/dartz.dart';
import 'package:flutter_connectivity_service/flutter_connectivity_service.dart';
import 'package:wheaterapp/data/datasource/weather_local_datasource.dart';
import 'package:wheaterapp/data/repositories/weather_repository.dart';

import '../../core/exception/network_exception.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/weather_event.dart';
import '../datasource/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource datasource;
  final WeatherLocalDatasource local;
  final ConnectionServices connectivity;

  WeatherRepositoryImpl(this.datasource, this.local, this.connectivity);

  @override
  Future<Either<Failure, List<WeatherEvent>>> getEvents(
      String location,
      ) async {
    final hasNet = connectivity.isConnected;

    if (hasNet.value) {
      try {
        final result =
        await datasource.getEvents(location);

        await local.cacheEvents(
          location,
          result,
        );

        return Right(result);

      } on NetworkException {
        final cached =
        local.getCachedEvents(location);

        if (cached.isNotEmpty) {
          return Right(cached);
        }

        return Left(NetworkFailure());

      } catch (_) {
        return Left(UnknownFailure());
      }
    }

    try {
      final cached =
      local.getCachedEvents(location);

      if (cached.isNotEmpty) {
        return Right(cached);
      }

      return Left(NetworkFailure());

    } catch (_) {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Weather>> getLast5Days(
      String city,
      ) async {
    final hasNet = connectivity.isConnected;

    if (hasNet.value) {
      try {
        final result =
        await datasource.getLast5Days(city);

        await local.cacheWeather(result);

        return Right(result);

      } on NetworkException {
        return Left(NetworkFailure());

      } catch (_) {
        return Left(UnknownFailure());
      }
    }

    try {
      final cached =
      local.getCachedWeather(city);

      if (cached != null) {
        return Right(cached);
      }

      return Left(NetworkFailure());

    } catch (_) {
      return Left(NetworkFailure());
    }
  }
}