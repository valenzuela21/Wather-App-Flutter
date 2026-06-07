import 'package:flutter_connectivity_service/flutter_connectivity_service.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:realm/realm.dart';
import '../../data/datasource/weather_local_datasource.dart';
import '../../data/datasource/weather_local_datasource_impl.dart';
import '../../data/datasource/weather_remote_datasource.dart';
import '../../data/models/event_cache.dart';
import '../../data/models/weather_cache.dart';
import '../../data/repositories/weather_repository.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/usecase/get_events_usecase.dart';
import '../../domain/usecase/get_weather_usecase.dart';
import '../../presentation/controllers/weather_controller.dart';

enum Flavor { dev, prod }

class AppConfig {

  static bool get isDev => appFlavor == 'prod';

  static Future<void> init() async {
    final realm = Realm(
      Configuration.local([
        WeatherCache.schema,
        EventCache.schema,
      ]),
    );

    Get.put<Realm>(realm, permanent: true);

    Get.put<ConnectionServices>(
      ConnectionServices(),
      permanent: true,
    );
  }
}