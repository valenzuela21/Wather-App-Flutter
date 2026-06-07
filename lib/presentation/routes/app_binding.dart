import 'package:flutter_connectivity_service/flutter_connectivity_service.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

import '../../data/datasource/weather_local_datasource.dart';
import '../../data/datasource/weather_local_datasource_impl.dart';
import '../../data/datasource/weather_remote_datasource.dart';
import '../../data/repositories/weather_repository.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/usecase/get_events_usecase.dart';
import '../../domain/usecase/get_weather_usecase.dart';
import '../controllers/weather_controller.dart';


class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherLocalDatasource>(
          () => WeatherLocalDatasourceImpl(
        Get.find<Realm>(),
      ),
    );

    Get.lazyPut<WeatherRemoteDatasource>(
          () => WeatherRemoteDatasource(),
    );

    Get.lazyPut<WeatherRepository>(
          () => WeatherRepositoryImpl(
        Get.find<WeatherRemoteDatasource>(),
        Get.find<WeatherLocalDatasource>(),
        Get.find<ConnectionServices>(),
      ),
    );

    Get.lazyPut<GetWeatherUseCase>(
          () => GetWeatherUseCase(
        Get.find<WeatherRepository>(),
      ),
    );

    Get.lazyPut<GetEventsUseCase>(
          () => GetEventsUseCase(
        Get.find<WeatherRepository>(),
      ),
    );

    Get.lazyPut<WeatherController>(
          () => WeatherController(
        Get.find<GetWeatherUseCase>(),
        Get.find<GetEventsUseCase>(),
      ),
    );
  }
}