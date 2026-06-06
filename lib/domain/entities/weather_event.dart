class WeatherEvent {
  final String id;
  final String type;
  final String title;
  final String description;
  final DateTime dateTime;
  final double? latitude;
  final double? longitude;

  WeatherEvent({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.dateTime,
    this.latitude,
    this.longitude,
  });
}