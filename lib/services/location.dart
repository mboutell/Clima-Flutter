import 'package:geolocator/geolocator.dart';

class LocationManager {
  static final LocationManager _instance =
      LocationManager._privateConstructor();

  factory LocationManager() {
    return _instance;
  }

  LocationManager._privateConstructor();

  // double latitude;
  // double longitude;
  Position _position;
  Function _callback;

  void startListening(Function callback) {
    _callback = callback;
    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.low)
        .listen((Position position) {
      // latitude = position.latitude;
      // longitude = position.longitude;
      _position = position;
      if (_callback != null) {
        _callback();
      }
    });
  }

  void stopListening() {
    _callback = null;
  }

  double get latitude => _position?.latitude ?? 0;

  double get longitude => _position?.longitude ?? 0;

  // Future<void> getCurrentLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.low);
  //     print(position);
  //     latitude = position.latitude;
  //     longitude = position.longitude;
  //   } catch (e) {
  //     print("Exception caught, no lat/long");
  //     latitude = 0;
  //     longitude = 0;
  //   }
  // }
}
