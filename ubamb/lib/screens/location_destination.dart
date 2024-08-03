import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ubamb/screens/account_screen.dart';
import 'package:ubamb/screens/home_screen.dart';
import 'package:ubamb/screens/maps2.dart';
import 'package:ubamb/screens/maps3.dart';
import 'package:ubamb/screens/ride_history.dart';
import 'package:ubamb/screens/starttrip_screen.dart';
import 'map_provider.dart'; // Import the MapProvider

class LocationDestinationScreen extends StatefulWidget {
  const LocationDestinationScreen({super.key});

  @override
  State<LocationDestinationScreen> createState() => _LocationDestinationScreenState();
}

class _LocationDestinationScreenState extends State<LocationDestinationScreen> {
  final String googlePlacesApiKey = 'AIzaSyBC-Vqf1uWwI6t57xo00OnzBf6LcqxsQ2E';
  final Completer<GoogleMapController> _controller = Completer();
  String _address = '';
  final String openCageApiKey = '0f7590f595cd460e8050da9a3eeddef7';

  Future<void> _getCurrentLocationAndAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _address = 'Error: Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _address = 'Error: Location permissions are denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _address = 'Error: Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }

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
      } else {
        setState(() {
          _address = 'Error: Failed to load address';
        });
      }
    } catch (e) {
      setState(() {
        _address = 'Error';
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
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFF4CA6F8),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 34),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF4CA6F8),
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.home, size: 31, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  HomeScreen()),
                      );
                    },
                    tooltip: 'Home',
                  ),
                  Text('Home'),
                ],
              ),

              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.history, size: 31, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  RideHistoryScreen()),
                      );
                    },

                  ),
                  Text('History'),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.account_circle, size: 31, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  AccountScreen()),
                      );
                    },

                  ),
                  Text('Account'),
                ],
              ),
              label: '',
            ),
          ],

        ),
      body: RefreshIndicator(onRefresh: _refreshScreen, child: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Row(
              children: [
                const SizedBox(width: 30),
                Column(
                  children: [
                    Container(
                      width: 300,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),

                      child:  Padding(

                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: _address,
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 300,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Padding(
                        padding:EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Aga Khan Hospital',
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/images/img_3.png',
                  width: 30,
                  height: 30,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 350,
              child: MpasScreen1(),
            ),

            const SizedBox(height: 50),
            Row(
              children: [
                const SizedBox(width: 70),
                GestureDetector(
                  onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TripScreen()),
                  );
                  },
                  child: Container(
                    width: 250,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Center(
                      child: Text(
                        'Done',
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
              ],
            ),
            const SizedBox(height: 50),
            const Divider(
              color: Colors.grey,
              thickness: 2,
            ),

          ],
        ),
      ),))

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
