// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentLocation;

  Position get currentLocation => _currentLocation as Position;

  set currentLocation(Position currentLocation) {
    _currentLocation = currentLocation;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _currentLocation = currentLocation;
    } catch (e) {
      Exception(e);
      Exception('Salah di Provider GeoLocator');
    }
  }
}
