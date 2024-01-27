import 'dart:async';

import 'package:location/location.dart';

class LocationServices {
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  final StreamController<LocationData> _locationStreamController =
      StreamController<LocationData>.broadcast();

  Stream<LocationData> get locationStream => _locationStreamController.stream;

  LocationData _locationData = LocationData.fromMap({});

  LocationData get currentLocation => _locationData;

  LocationServices() {
    location.requestPermission().then((value) async {
      if (value == PermissionStatus.granted) {
        // location.onLocationChanged.listen((LocationData currentLocation) {
        //   _locationStreamController.add(currentLocation);
        // });
        _locationData = await location.getLocation();
      }
    });
  }

  void dispose() {
    _locationStreamController.close();
  }

  Future getUserLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    // if (locationData.isMock!) {
    //   _locationData = await location.getLocation();
    // }

    _locationData = await location.getLocation();
    return _locationData;
  }
}
