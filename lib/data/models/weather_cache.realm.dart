// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_cache.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class WeatherCache extends _WeatherCache
    with RealmEntity, RealmObjectBase, RealmObject {
  WeatherCache(String city, String jsonData, DateTime updatedAt) {
    RealmObjectBase.set(this, 'city', city);
    RealmObjectBase.set(this, 'jsonData', jsonData);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  WeatherCache._();

  @override
  String get city => RealmObjectBase.get<String>(this, 'city') as String;
  @override
  set city(String value) => RealmObjectBase.set(this, 'city', value);

  @override
  String get jsonData =>
      RealmObjectBase.get<String>(this, 'jsonData') as String;
  @override
  set jsonData(String value) => RealmObjectBase.set(this, 'jsonData', value);

  @override
  DateTime get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime;
  @override
  set updatedAt(DateTime value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  Stream<RealmObjectChanges<WeatherCache>> get changes =>
      RealmObjectBase.getChanges<WeatherCache>(this);

  @override
  Stream<RealmObjectChanges<WeatherCache>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<WeatherCache>(this, keyPaths);

  @override
  WeatherCache freeze() => RealmObjectBase.freezeObject<WeatherCache>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'city': city.toEJson(),
      'jsonData': jsonData.toEJson(),
      'updatedAt': updatedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(WeatherCache value) => value.toEJson();
  static WeatherCache _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'city': EJsonValue city,
        'jsonData': EJsonValue jsonData,
        'updatedAt': EJsonValue updatedAt,
      } =>
        WeatherCache(
          fromEJson(city),
          fromEJson(jsonData),
          fromEJson(updatedAt),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(WeatherCache._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      WeatherCache,
      'WeatherCache',
      [
        SchemaProperty('city', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('jsonData', RealmPropertyType.string),
        SchemaProperty('updatedAt', RealmPropertyType.timestamp),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
