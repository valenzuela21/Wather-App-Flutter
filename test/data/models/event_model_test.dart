import 'package:flutter_test/flutter_test.dart';
import 'package:wheaterapp/data/models/event_cache.dart';
import 'package:wheaterapp/data/models/event_model.dart';

import '../../fixtures/weather_fixtures.dart';

void main() {
  group('EventModel', () {
    test('fromJson mapea los campos del evento meteorológico', () {
      final model = EventModel.fromJson(sampleEventJson);

      expect(model.id, '2026-06-07');
      expect(model.type, 'Tormenta');
      expect(model.title, 'Tormenta');
      expect(model.description, 'Posible tormenta eléctrica por la tarde');
      expect(model.dateTime, DateTime.parse('2026-06-07'));
    });

    test('fromCache reconstruye el evento desde EventCache', () {
      final cache = EventCache(
        'event-1',
        'storm',
        'Tormenta',
        'Posible tormenta eléctrica',
        DateTime(2026, 6, 7),
        latitude: 4.71,
        longitude: -74.07,
      );

      final model = EventModel.fromCache(cache);

      expect(model.id, cache.id);
      expect(model.type, cache.type);
      expect(model.title, cache.title);
      expect(model.description, cache.description);
      expect(model.latitude, 4.71);
      expect(model.longitude, -74.07);
    });

    test('toCache convierte el modelo a EventCache', () {
      final model = EventModel.fromJson(sampleEventJson);

      final cache = model.toCache();

      expect(cache.id, model.id);
      expect(cache.type, model.type);
      expect(cache.title, model.title);
      expect(cache.description, model.description);
      expect(cache.dateTime, model.dateTime);
    });
  });
}
