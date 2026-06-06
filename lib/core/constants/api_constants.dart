import 'package:flutter/services.dart';
import '../utils/app_config.dart';

class ApiConstants {
  static const apiKey = "Q5RLJ4X6E9MJFUFV9PXYYN379";

  static String get baseUrl {
    if (appFlavor == Flavor.prod) {
      return "https://weather.visualcrossing.com";
    }else{
      return "https://weather.visualcrossing.com";
    }
  }

  static const timelineEndpoint = '/timeline';
}