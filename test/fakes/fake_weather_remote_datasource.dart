import 'package:wheaterapp/core/network/network_info.dart';
import 'package:wheaterapp/data/datasource/weather_remote_datasource.dart';
import 'package:wheaterapp/data/models/event_model.dart';
import 'package:wheaterapp/data/models/weather_model.dart';

class FakeNetworkInfo implements NetworkInfo {
  FakeNetworkInfo({this.connected = true});

  bool connected;

  @override
  Future<bool> get isConnected async => connected;
}

class FakeWeatherRemoteDatasource extends WeatherRemoteDatasource {
  FakeWeatherRemoteDatasource({NetworkInfo? networkInfo})
      : super(networkInfo: networkInfo ?? FakeNetworkInfo());

  List<EventModel> eventsResult = [];
  WeatherModel? weatherResult;
  Object? errorToThrow;

  @override
  Future<List<EventModel>> getEvents(String location) async {
    if (errorToThrow != null) {
      throw errorToThrow!;
    }
    return eventsResult;
  }

  @override
  Future<WeatherModel> getLast5Days(String city) async {
    if (errorToThrow != null) {
      throw errorToThrow!;
    }
    return weatherResult!;
  }
}
