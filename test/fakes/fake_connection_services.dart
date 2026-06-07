import 'package:flutter_connectivity_service/flutter_connectivity_service.dart';

class FakeConnectionServices extends ConnectionServices {
  FakeConnectionServices({bool connected = true}) {
    isConnected.value = connected;
  }

  void setConnected(bool value) {
    isConnected.value = value;
  }

  @override
  void onInit() {}
}
