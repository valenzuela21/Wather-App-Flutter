import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wheaterapp/core/exception/network_exception.dart';
import 'package:wheaterapp/data/models/weather_model.dart';
import 'package:wheaterapp/presentation/pages/events_page.dart';
import 'package:wheaterapp/presentation/pages/weather_page.dart';

import '../../fixtures/weather_fixtures.dart';
import '../../helpers/widget_test_helpers.dart';

void main() {
  final harness = WidgetTestHarness();

  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(harness.setUp);

  tearDown(harness.tearDown);

  group('WeatherPage', () {
    testWidgets('muestra indicador de carga mientras obtiene datos', (tester) async {
      harness.repository.pendingWeather = Completer();

      await harness.pumpApp(tester, const WeatherPage());
      await tester.pump();
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Weather'), findsOneWidget);

      harness.repository.pendingWeather!.complete(Right(sampleWeatherModel()));
      await tester.pumpAndSettle();
    });

    testWidgets('muestra datos del clima cuando la carga es exitosa', (tester) async {
      harness.repository.weatherResult = Right(sampleWeatherModel());

      await harness.pumpApp(tester, const WeatherPage());
      await harness.settleAsyncLoad(tester);

      expect(find.text('Bogota, Colombia'), findsOneWidget);
      expect(find.text('Parcialmente nublado'), findsWidgets);
      expect(find.text('23°'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('navega a pantalla sin internet cuando falla la red', (tester) async {
      harness.repository.weatherResult = Left(NetworkFailure());

      await harness.pumpApp(tester, const WeatherPage());
      await harness.settleAsyncLoad(tester);

      expect(find.text('Sin conexión a Internet'), findsOneWidget);
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
    });

    testWidgets('renderiza tarjetas del pronóstico', (tester) async {
      harness.repository.weatherResult = Right(sampleWeatherModel());

      await harness.pumpApp(tester, const WeatherPage());
      await harness.settleAsyncLoad(tester);

      expect(find.text('18° / 25°'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });

  group('EventsPage', () {
    testWidgets('muestra indicador de carga mientras obtiene datos', (tester) async {
      harness.repository.pendingEvents = Completer();

      await harness.pumpApp(tester, const EventsPage());
      await tester.pump();
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Events Weather'), findsOneWidget);

      harness.repository.pendingEvents!.complete(Right([sampleWeatherEvent()]));
      await tester.pumpAndSettle();
    });

    testWidgets('muestra lista de eventos cuando la carga es exitosa', (tester) async {
      harness.repository.eventsResult = Right([sampleWeatherEvent()]);

      await harness.pumpApp(tester, const EventsPage());
      await harness.settleAsyncLoad(tester);

      expect(find.text('Tormenta'), findsWidgets);
      expect(find.text('storm'), findsOneWidget);
      expect(find.byIcon(Icons.thunderstorm), findsOneWidget);
      expect(find.text('No events found'), findsNothing);
    });

    testWidgets('muestra mensaje vacío cuando no hay eventos', (tester) async {
      harness.repository.eventsResult = const Right([]);

      await harness.pumpApp(tester, const EventsPage());
      await harness.settleAsyncLoad(tester);

      expect(find.text('No events found'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('navega a pantalla sin internet cuando falla la red', (tester) async {
      harness.repository.eventsResult = Left(NetworkFailure());

      await harness.pumpApp(tester, const EventsPage());
      await harness.settleAsyncLoad(tester);

      expect(find.text('Sin conexión a Internet'), findsOneWidget);
    });

    testWidgets('navega al detalle al pulsar un evento', (tester) async {
      harness.repository.eventsResult = Right([sampleWeatherEvent()]);

      await harness.pumpApp(tester, const EventsPage());
      await harness.settleAsyncLoad(tester);

      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      expect(find.text('Tormenta'), findsWidgets);
      expect(find.text('Posible tormenta eléctrica'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });
  });
}
