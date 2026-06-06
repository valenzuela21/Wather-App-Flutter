import 'package:get/get.dart';
import 'package:wheaterapp/presentation/pages/weather_page.dart';
import '../pages/event_detail_page.dart';
import '../pages/events_page.dart';
import 'app_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.events,
      page: () => const EventsPage(),
      binding: WeatherBinding(),
    ),
    GetPage(
      name: Routes.eventDetail,
      page: () => EventDetailPage(),
      binding: WeatherBinding(),
    ),
    GetPage(
      name: Routes.weather,
      page: () => WeatherPage(),
      binding: WeatherBinding(),
    ),
  ];
}