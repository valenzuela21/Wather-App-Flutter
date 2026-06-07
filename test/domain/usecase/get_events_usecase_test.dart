import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wheaterapp/core/exception/network_exception.dart';
import 'package:wheaterapp/domain/usecase/get_events_usecase.dart';

import '../../fakes/fake_weather_repository.dart';
import '../../fixtures/weather_fixtures.dart';

void main() {
  late FakeWeatherRepository repository;
  late GetEventsUseCase useCase;

  setUp(() {
    repository = FakeWeatherRepository();
    useCase = GetEventsUseCase(repository);
  });

  test('delega en el repositorio y devuelve los eventos', () async {
    final events = [sampleWeatherEvent()];
    repository.eventsResult = Right(events);

    final result = await useCase(sampleCity);

    expect(result, Right(events));
    expect(repository.lastEventsLocation, sampleCity);
  });

  test('propaga fallos del repositorio', () async {
    repository.eventsResult = Left(NetworkFailure());

    final result = await useCase(sampleCity);

    expect(result.isLeft(), isTrue);
    expect(result.swap().getOrElse(() => throw Exception()), isA<NetworkFailure>());
  });
}
