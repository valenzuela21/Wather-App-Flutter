import 'package:realm/realm.dart';

part 'event_cache.realm.dart';

@RealmModel()
class _EventCache {
  @PrimaryKey()
  late String id;

  late String type;
  late String title;
  late String description;
  late DateTime dateTime;

  double? latitude;
  double? longitude;
}