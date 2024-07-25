// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
// import 'location_service.dart';
//
// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   Position? _currentPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     try {
//       final position = await LocationService().getCurrentLocation();
//       setState(() {
//         _currentPosition = position;
//       });
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Current Location')),
//       body: _currentPosition == null
//           ? Center(child: CircularProgressIndicator())
//           : FlutterMap(
//         options: MapOptions(
//           center: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//           zoom: 13.0,
//         ),
//         layers: [
//           TileLayerOptions(
//             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: ['a', 'b', 'c'],
//           ),
//           MarkerLayerOptions(
//             markers: [
//               Marker(
//                 width: 80.0,
//                 height: 80.0,
//                 point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//                 builder: (ctx) => Container(
//                   child: Icon(Icons.location_on, color: Colors.red),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
