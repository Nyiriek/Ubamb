import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String googleAPiKey = "AIzaSyBlH5qHnSOIk0v4rM6smayKIw5kKDAfSNc";
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng finalLocation = LatLng(-1.0712151183174405, 36.62940146189086);
  List<LatLng> polyCoordinates = [];
  LocationData? currentLocatioN;

  void getCurrentLocation (){
    Location location = Location();
    location.getLocation().then(
            (location) {
          currentLocatioN = location;

        });
    location.onLocationChanged.listen(
            (newLoc) {
          currentLocatioN = newLoc;
          setState(() {

          });
        }
    );


  }
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleAPiKey,
      request: PolylineRequest(
        origin: PointLatLng(currentLocatioN!.latitude!, currentLocatioN!.longitude! ),
        destination: PointLatLng(finalLocation.latitude, finalLocation.longitude),
        mode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Nairobi Kenya")],
      ),
    );
    if (result.points.isNotEmpty){
      result.points.forEach(
              (PointLatLng point) => polyCoordinates.add(LatLng(point.latitude, point.longitude))
      );
      setState(() {

      });
    } else {
      print("No points");
    }
    print(result.points);
  }

  @override
  void initState(){
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        child: currentLocatioN == null
            ? const Center(child: CircularProgressIndicator())
            :GoogleMap(initialCameraPosition:
        CameraPosition(target: LatLng(currentLocatioN!.latitude!, currentLocatioN!.longitude!),
            zoom: 15),
          polylines: {
            Polyline(
              polylineId: PolylineId('route'),
              points: polyCoordinates,
              color: Colors.blue,
            ),
          },
          markers: {
            Marker(
              markerId: MarkerId('source'),
              position: LatLng(currentLocatioN!.latitude!, currentLocatioN!.longitude!),

            ),
            Marker(
                markerId: MarkerId('destination'),
                position: finalLocation
            ),
          },
      ),
      ),
    );
  }
}
