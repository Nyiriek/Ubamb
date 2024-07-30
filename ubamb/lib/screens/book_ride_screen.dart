import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ubamb/screens/pickup_location.dart';
import 'home_screen.dart';
import 'account_screen.dart';
import 'dart:convert';
class BookRideScreen extends StatefulWidget {
  const BookRideScreen({super.key});

  @override
  State<BookRideScreen> createState() => _BookRideScreenState();
}

class _BookRideScreenState extends State<BookRideScreen> {
  final String googlePlacesApiKey = 'AIzaSyBtLcz3wFle9yVX1qIMYkslV9VYNxTog3E';
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(-1.1601355651827767, 36.93819294757183);
  static const LatLng destination =  LatLng(-1.2398740986522414, 36.72430824238126);
  Future<void> _refreshScreen() async {
    setState(() {
       // Trigger a rebuild of the widget tree
    });

   await _getCurrentLocationAndAddress();
  }
  String _address = '';
  final String openCageApiKey = '0f7590f595cd460e8050da9a3eeddef7';
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? _currentLocation;

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
          _currentLocation = LatLng(position.latitude, position.longitude);
          _markers.add(Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentLocation!,
            infoWindow: InfoWindow(title: 'Your Location', snippet: _address),
          ));
        });
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
    if (_currentLocation == null) return;

    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentLocation!.latitude},${_currentLocation!.longitude}&radius=1500&type=$type&key=$googlePlacesApiKey';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      List<dynamic> places = result['results'];
      setState(() {
        _markers.clear();
        places.forEach((place) {
          _markers.add(Marker(
            markerId: MarkerId(place['place_id']),
            position: LatLng(place['geometry']['location']['lat'], place['geometry']['location']['lng']),
            infoWindow: InfoWindow(title: place['name'], snippet: place['vicinity']),
          ));
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndAddress();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
      body: RefreshIndicator(
        onRefresh: _refreshScreen,
        child:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 55),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.black, size: 34),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 400,
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
                     GestureDetector(
                    onVerticalDragUpdate: (details) {
                      // Prevent vertical scroll events from reaching the SingleChildScrollView
                    },

                    // Adjust the height as needed
                   child: Container(
                     height: 350,
                     child: GoogleMap(

                       onMapCreated: (controller) {
                     setState(() {
                     _mapController = controller;
                     });
                     },
                       initialCameraPosition: CameraPosition(
                         target: _currentLocation ?? LatLng(0, 0),
                         zoom: 15,
                       ),
                       markers: _markers,
                       cloudMapId: '34a385aaf8f3110e',

                     ),
                   ),
                  ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/img_1.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 15),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Taxi',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text('16.30 - 3 min away'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            '1,200 ksh',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/img.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 15),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ambulance',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text('16.00 - 10 min away'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            '3,000 ksh',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 75),
                Row(
                  children: [
                    const SizedBox(width: 70),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PickupLocationScreen()),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text(
                            'Book ride',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 70,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Center(
                        child: Icon(Icons.local_taxi_outlined),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.home, size: 31, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  HomeScreen()),
                            );
                          },
                        ),
                        const Text('Home'),
                      ],
                    ),
                    const Column(
                      children: [
                        Icon(Icons.history, size: 31),
                        SizedBox(height: 7),
                        Text('History'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.account_circle, size: 31, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  AccountScreen()),
                            );
                          },
                        ),
                        const Text('Account'),
                      ],
                    ),
                  ],
                ),
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

