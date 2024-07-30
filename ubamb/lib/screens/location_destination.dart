import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'map_provider.dart'; // Import the MapProvider

class LocationDestinationScreen extends StatefulWidget {
  const LocationDestinationScreen({super.key});

  @override
  State<LocationDestinationScreen> createState() => _LocationDestinationScreenState();
}

class _LocationDestinationScreenState extends State<LocationDestinationScreen> {
  final String googlePlacesApiKey = 'AIzaSyBtLcz3wFle9yVX1qIMYkslV9VYNxTog3E';
  final Completer<GoogleMapController> _controller = Completer();
  String _address = '';
  final String openCageApiKey = '0f7590f595cd460e8050da9a3eeddef7';

  Future<void> _getCurrentLocationAndAddress() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String url =
          'https://api.opencagedata.com/geocode/v1/json?q=${position.latitude}+${position.longitude}&key=$openCageApiKey';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        String address = result['results'][0]['formatted'];
        setState(() {
          _address = address;
        });
        Provider.of<MapProvider>(context, listen: false).setCurrentLocation(LatLng(position.latitude, position.longitude));
        Provider.of<MapProvider>(context, listen: false).addMarker(Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: 'Your Location', snippet: _address),
        ));
      } else {
        setState(() {
          _address = 'Error: Failed to load address';
        });
      }
    } catch (e) {
      setState(() {
        _address = 'Error: $e';
      });
    }
  }

  Future<void> _searchNearbyPlaces(String type) async {
    MapProvider mapProvider = Provider.of<MapProvider>(context, listen: false);
    if (mapProvider.currentLocation == null) return;

    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${mapProvider.currentLocation!.latitude},${mapProvider.currentLocation!.longitude}&radius=1500&type=$type&key=$googlePlacesApiKey';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      List<dynamic> places = result['results'];
      mapProvider.clearMarkers();
      places.forEach((place) {
        mapProvider.addMarker(Marker(
          markerId: MarkerId(place['place_id']),
          position: LatLng(place['geometry']['location']['lat'], place['geometry']['location']['lng']),
          infoWindow: InfoWindow(title: place['name'], snippet: place['vicinity']),
        ));
      });
    }
  }

  Future<void> _refreshScreen() async {
    setState(() {
      // Trigger a rebuild of the widget tree
    });

    await _getCurrentLocationAndAddress();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndAddress();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapProvider(),
      child: Scaffold(
        backgroundColor: const Color(0xFF4CA6F8),
        body: RefreshIndicator(
          onRefresh: _refreshScreen,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 55),
                const SizedBox(height: 20),
                Container(
                  height: 600,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => _searchNearbyPlaces('restaurant'),
                            child: Text('Restaurants'),
                          ),
                          ElevatedButton(
                            onPressed: () => _searchNearbyPlaces('lodging'),
                            child: Text('Hotels'),
                          ),
                          ElevatedButton(
                            onPressed: () => _searchNearbyPlaces('hospital'),
                            child: Text('Hospitals'),
                          ),
                        ],
                      ),
                      SingleChildScrollView(child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                          // Prevent vertical scroll events from reaching the SingleChildScrollView
                        },
                        child: Container(
                          height: 550,
                          child: Consumer<MapProvider>(
                            builder: (context, mapProvider, child) {
                              return GoogleMap(
                                onMapCreated: (controller) {
                                  mapProvider.setMapController(controller);
                                },
                                initialCameraPosition: CameraPosition(
                                  target: mapProvider.currentLocation ?? LatLng(0, 0),
                                  zoom: 15,
                                ),
                                markers: mapProvider.markers,
                                mapType: MapType.normal,
                              );
                            },
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context,
      {required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.black),
              ),
              const SizedBox(width: 15),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
