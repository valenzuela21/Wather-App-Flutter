import 'package:realm/realm.dart';

part 'weather_cache.realm.dart';

@RealmModel()
class _WeatherCache {
  @PrimaryKey()
  late String city;

  late String jsonData;

  late DateTime updatedAt;
}