import 'package:wheaterapp/data/models/event_model.dart';
import 'package:wheaterapp/data/models/weather_model.dart';
import 'package:wheaterapp/domain/entities/weather.dart';
import 'package:wheaterapp/domain/entities/weather_event.dart';

const sampleCity = 'Bogota';

final sampleWeatherJson = {
  'resolvedAddress': 'Bogota, Colombia',
  'currentConditions': {
    'temp': 22.5,
    'conditions': 'Parcialmente nublado',
  },
  'days': [
    {
      'datetime': '2026-06-07',
      'tempmax': 25.0,
      'tempmin': 18.0,
      'conditions': 'Parcialmente nublado',
    },
    {
      'datetime': '2026-06-08',
      'tempmax': 26.0,
      'tempmin': 17.5,
      'conditions': 'Lluvia ligera',
    },
    {
      'datetime': '2026-06-09',
      'tempmax': 24.0,
      'tempmin': 16.0,
      'conditions': 'Nublado',
    },
    {
      'datetime': '2026-06-10',
      'tempmax': 23.0,
      'tempmin': 15.5,
      'conditions': 'Despejado',
    },
    {
      'datetime': '2026-06-11',
      'tempmax': 27.0,
      'tempmin': 19.0,
      'conditions': 'Soleado',
    },
    {
      'datetime': '2026-06-12',
      'tempmax': 28.0,
      'tempmin': 20.0,
      'conditions': 'Soleado',
    },
  ],
};

final sampleEventJson = {
  'datetime': '2026-06-07',
  'conditions': 'Tormenta',
  'description': 'Posible tormenta eléctrica por la tarde',
};

WeatherModel sampleWeatherModel() => WeatherModel.fromJson(sampleWeatherJson);

List<EventModel> sampleEventModels() => [
      EventModel.fromJson(sampleEventJson),
    ];

WeatherEvent sampleWeatherEvent() => EventModel(
      id: 'event-1',
      type: 'storm',
      title: 'Tormenta',
      description: 'Posible tormenta eléctrica',
      dateTime: DateTime(2026, 6, 7),
    );

Weather sampleWeatherEntity() => Weather(
      city: sampleCity,
      currentTemp: 22.5,
      condition: 'Parcialmente nublado',
      forecast: [
        ForecastDay(
          date: DateTime(2026, 6, 7),
          tempMax: 25,
          tempMin: 18,
          conditions: 'Parcialmente nublado',
        ),
      ],
    );
