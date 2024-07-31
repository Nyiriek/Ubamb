import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapsScreen2 extends StatefulWidget {
  MapsScreen2({super.key});

  @override
  State<MapsScreen2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapsScreen2> {
  String googleAPiKey = "AIzaSyBC-Vqf1uWwI6t57xo00OnzBf6LcqxsQ2E";
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(-1.2048754551598329, 36.910607512531456);
  static const LatLng finalLocation = LatLng(-1.0712151183174405, 36.62940146189086);

  List<LatLng> polyCoordinates = [];
  LocationData? currentLocatioN;
  String placeName = "Loading...";

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocatioN = location;
    });
    location.onLocationChanged.listen((newLoc) {
      currentLocatioN = newLoc;
      setState(() {});
    });
  }

  Future<void> getPlaceName(LatLng location) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&key=$googleAPiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['results'].isNotEmpty) {
        setState(() {
          placeName = data['results'][0]['formatted_address'];
        });
      }
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPlaceName(finalLocation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: currentLocatioN == null
            ? const Center(child: Text("Loading..."))
            : GoogleMap(
          initialCameraPosition: CameraPosition(
            target: finalLocation,
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId: MarkerId('final'),
              position: finalLocation,
              infoWindow: InfoWindow(
                title: placeName,
              ),
            ),
          },
        ),
      ),
    );
  }
}
