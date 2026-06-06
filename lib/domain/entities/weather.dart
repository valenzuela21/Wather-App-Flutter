class Weather {
  final String city;
  final double currentTemp;
  final String condition;
  final List<ForecastDay> forecast;

  Weather({
    required this.city,
    required this.currentTemp,
    required this.condition,
    required this.forecast,
  });
}

class ForecastDay {
  final DateTime date;
  final double tempMax;
  final double tempMin;
  final String conditions;

  ForecastDay({
    required this.date,
    required this.tempMax,
    required this.tempMin,
    required this.conditions,
  });
}