import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  LatLng? _currentLocation;
  String _errorMessage = '';

  GoogleMapController? get mapController => _mapController;
  Set<Marker> get markers => _markers;
  LatLng? get currentLocation => _currentLocation;
  String get errorMessage => _errorMessage;

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  void setCurrentLocation(LatLng location) {
    _currentLocation = location;
    notifyListeners();
  }

  void addMarker(Marker marker) {
    _markers.add(marker);
    notifyListeners();
  }

  void clearMarkers() {
    _markers.clear();
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
