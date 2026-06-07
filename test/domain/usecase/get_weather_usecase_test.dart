import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wheaterapp/core/exception/network_exception.dart';
import 'package:wheaterapp/domain/usecase/get_weather_usecase.dart';

import '../../fakes/fake_weather_repository.dart';
import '../../fixtures/weather_fixtures.dart';

void main() {
  late FakeWeatherRepository repository;
  late GetWeatherUseCase useCase;

  setUp(() {
    repository = FakeWeatherRepository();
    useCase = GetWeatherUseCase(repository);
  });

  test('delega en el repositorio y devuelve el clima', () async {
    final weather = sampleWeatherEntity();
    repository.weatherResult = Right(weather);

    final result = await useCase(sampleCity);

    expect(result, Right(weather));
    expect(repository.lastWeatherCity, sampleCity);
  });

  test('propaga fallos del repositorio', () async {
    repository.weatherResult = Left(NetworkFailure());

    final result = await useCase(sampleCity);

    expect(result.isLeft(), isTrue);
    expect(result.swap().getOrElse(() => throw Exception()), isA<NetworkFailure>());
  });
}
