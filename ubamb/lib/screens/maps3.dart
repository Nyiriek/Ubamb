import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapsScreen extends StatefulWidget {
  MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapsScreen> {
  String googleAPiKey = "AIzaSyC_C1dMtojjSM0aIlJPTE35-1XoscjuFhI";
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocatioN;
  Location location = Location();
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    try {
      LocationData locationData = await location.getLocation();
      setState(() {
        currentLocatioN = locationData;
      });
    } catch (e) {
      print("Error: $e");
    }
    location.onLocationChanged.listen((newLoc) {
      setState(() {
        currentLocatioN = newLoc;
      });
    });
  }

  Future<void> _fetchNearbyPlaces(String type) async {
    if (currentLocatioN == null) return;

    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentLocatioN!.latitude},${currentLocatioN!.longitude}&radius=1500&type=$type&key=$googleAPiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        markers.clear();
        for (var result in data['results']) {
          markers.add(
            Marker(
              markerId: MarkerId(result['place_id']),
              position: LatLng(result['geometry']['location']['lat'], result['geometry']['location']['lng']),
              infoWindow: InfoWindow(title: result['name']),
            ),
          );
        }
      });
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    if (currentLocatioN != null) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocatioN!.latitude!, currentLocatioN!.longitude!),
            zoom: 15,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocatioN == null
          ? Center(child: CircularProgressIndicator())
          : Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () => _fetchNearbyPlaces('restaurant'), child: Icon(Icons.restaurant)),
                  ElevatedButton(onPressed: () => _fetchNearbyPlaces('hospital'), child: Icon(Icons.local_hospital)),
                  ElevatedButton(onPressed: () => _fetchNearbyPlaces('school'), child: Icon(Icons.school)),
                  ElevatedButton(onPressed: () => _fetchNearbyPlaces('church'), child: Icon(Icons.church)),
                  ElevatedButton(onPressed: () => _fetchNearbyPlaces('government_office'), child: Icon(Icons.account_balance))
                ]
            ),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocatioN!.latitude!, currentLocatioN!.longitude!),
                      zoom: 15,
                    ),
                    markers: markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: _goToCurrentLocation,
                      child: Icon(Icons.my_location),
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}
