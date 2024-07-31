import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ubamb/screens/maps4.dart';
import 'package:ubamb/screens/ongoing_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {

  final String openCageApiKey = '0f7590f595cd460e8050da9a3eeddef7';
  String _address = '';
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
  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:  IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black, size: 34),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: MapsScreen1(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF4CA6F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Ongoing Trip',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const  Divider(
                      color: Colors.white,
                      thickness: 5,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Muli',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                     Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'PICKUP LOCATION',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                     _address,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'DROPOFF LOCATION',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Aga Khan Hospital, Parklands',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OngoingScreen()),
                          );
                          // Add your start trip functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 100.0,
                            vertical: 16.0,
                          ),
                        ),
                        child: const Text(
                          'START TRIP',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

