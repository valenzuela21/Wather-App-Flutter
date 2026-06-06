// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_cache.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class EventCache extends _EventCache
    with RealmEntity, RealmObjectBase, RealmObject {
  EventCache(
    String id,
    String type,
    String title,
    String description,
    DateTime dateTime, {
    double? latitude,
    double? longitude,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'dateTime', dateTime);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
  }

  EventCache._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  DateTime get dateTime =>
      RealmObjectBase.get<DateTime>(this, 'dateTime') as DateTime;
  @override
  set dateTime(DateTime value) => RealmObjectBase.set(this, 'dateTime', value);

  @override
  double? get latitude =>
      RealmObjectBase.get<double>(this, 'latitude') as double?;
  @override
  set latitude(double? value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  double? get longitude =>
      RealmObjectBase.get<double>(this, 'longitude') as double?;
  @override
  set longitude(double? value) => RealmObjectBase.set(this, 'longitude', value);

  @override
  Stream<RealmObjectChanges<EventCache>> get changes =>
      RealmObjectBase.getChanges<EventCache>(this);

  @override
  Stream<RealmObjectChanges<EventCache>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<EventCache>(this, keyPaths);

  @override
  EventCache freeze() => RealmObjectBase.freezeObject<EventCache>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'type': type.toEJson(),
      'title': title.toEJson(),
      'description': description.toEJson(),
      'dateTime': dateTime.toEJson(),
      'latitude': latitude.toEJson(),
      'longitude': longitude.toEJson(),
    };
  }

  static EJsonValue _toEJson(EventCache value) => value.toEJson();
  static EventCache _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'type': EJsonValue type,
        'title': EJsonValue title,
        'description': EJsonValue description,
        'dateTime': EJsonValue dateTime,
      } =>
        EventCache(
          fromEJson(id),
          fromEJson(type),
          fromEJson(title),
          fromEJson(description),
          fromEJson(dateTime),
          latitude: fromEJson(ejson['latitude']),
          longitude: fromEJson(ejson['longitude']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(EventCache._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      EventCache,
      'EventCache',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('type', RealmPropertyType.string),
        SchemaProperty('title', RealmPropertyType.string),
        SchemaProperty('description', RealmPropertyType.string),
        SchemaProperty('dateTime', RealmPropertyType.timestamp),
        SchemaProperty('latitude', RealmPropertyType.double, optional: true),
        SchemaProperty('longitude', RealmPropertyType.double, optional: true),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
