import 'package:get/get.dart';
import 'package:wheaterapp/core/utils/helpers.dart';

import '../../core/exception/network_exception.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/weather_event.dart';
import '../../domain/usecase/get_events_usecase.dart';
import '../../domain/usecase/get_weather_usecase.dart';
import '../pages/no_internet_page.dart';

class WeatherController extends GetxController {
  final GetWeatherUseCase getWeatherUseCase;
  final GetEventsUseCase getEventsUseCase;

  WeatherController(this.getWeatherUseCase, this.getEventsUseCase);

  final weather = Rxn<Weather>();
  final RxList<WeatherEvent> events = <WeatherEvent>[].obs;
  final RxBool loading = false.obs;

  Future<void> loadEvents(String city) async {
    loading.value = true;

    final result = await getEventsUseCase(city);

    result.fold(
      (failure) {
        if (failure is NetworkFailure) {
          Get.to(() => const NoInternetPage());
        }
        events.clear();
      },
      (data) {
        events.value = data;
      },
    );

    loading.value = false;
  }

  Future<void> loadWeather(String city) async {
    loading.value = true;

    final result = await getWeatherUseCase(city);

    result.fold(
      (failure) {
        if (failure is NetworkFailure) {
          Get.to(() => const NoInternetPage());
        }

        weather.value = null;
      },
      (data) {
        weather.value = data;
      },
    );

    loading.value = false;
  }
}
