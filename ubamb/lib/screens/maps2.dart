import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MpasScreen1 extends StatefulWidget {
  MpasScreen1({super.key});

  @override
  State<MpasScreen1> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MpasScreen1> {
  String placeName = "Loading...";
  String googleAPiKey = "AIzaSyBC-Vqf1uWwI6t57xo00OnzBf6LcqxsQ2E";
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocatioN;
  Location location = Location();
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() {
    location.getLocation().then((location) {
      currentLocatioN = location;
    });
    location.onLocationChanged.listen((newLoc) {
      currentLocatioN = newLoc;
      setState(() {});
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: currentLocatioN == null
          ?  Center(child:Text("Loading..."))
          : Stack(
        children: [
          Positioned(
            child: Column(

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed:  () => _fetchNearbyPlaces('restaurant'),  child: Icon(Icons.restaurant)),
                ElevatedButton(onPressed:  () => _fetchNearbyPlaces('hospital'),  child: Icon(Icons.local_hospital)),
                ElevatedButton(onPressed:  () => _fetchNearbyPlaces('school'),  child: Icon(Icons.school)),
                ElevatedButton(onPressed:  () => _fetchNearbyPlaces('church'),  child: Icon(Icons.church)),
                ElevatedButton(onPressed:  () => _fetchNearbyPlaces('government_office'),  child: Icon(Icons.account_balance))
              ]
          ),
          Container(height: 250, child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(currentLocatioN!.latitude!, currentLocatioN!.longitude!),
              zoom: 15,
            ),

            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                markerId: MarkerId('source'),
                position: LatLng(currentLocatioN!.latitude!, currentLocatioN!.longitude!),
                infoWindow: InfoWindow(
                  title: placeName,
                ),
              ),
            },
          ),)
        ]
      ),
      ),
          Positioned(
            top: 145,
            right: 5,
            child: FloatingActionButton(

              onPressed: _goToCurrentLocation,
              child: Icon(Icons.my_location,),
            ),
          ),
    ],
      )
    );
  }
}
