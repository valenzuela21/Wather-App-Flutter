import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:wheaterapp/domain/usecase/get_events_usecase.dart';
import 'package:wheaterapp/domain/usecase/get_weather_usecase.dart';
import 'package:wheaterapp/presentation/controllers/weather_controller.dart';
import 'package:wheaterapp/presentation/pages/event_detail_page.dart';
import 'package:wheaterapp/presentation/routes/app_routes.dart';

import '../fakes/fake_weather_repository.dart';

class WidgetTestHarness {
  late FakeWeatherRepository repository;
  late WeatherController controller;

  void setUp() {
    Get.reset();
    Get.testMode = true;
    repository = FakeWeatherRepository();
    controller = WeatherController(
      GetWeatherUseCase(repository),
      GetEventsUseCase(repository),
    );
    Get.put<WeatherController>(controller);
  }

  void tearDown() {
    Get.closeAllSnackbars();
    Get.reset();
  }

  Future<void> pumpApp(WidgetTester tester, Widget home) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: home,
        getPages: [
          GetPage(
            name: Routes.eventDetail,
            page: () => const EventDetailPage(),
          ),
        ],
      ),
    );
  }

  Future<void> settleAsyncLoad(WidgetTester tester) async {
    await tester.pump();
    await tester.pump();
    await tester.pumpAndSettle();
  }
}
