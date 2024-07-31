import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ubamb/screens/account_screen.dart';
import 'package:ubamb/screens/home_screen.dart';
import 'package:ubamb/screens/settings_privacy.dart';
import 'userinfo.dart';
import 'package:ubamb/screens/ride_history.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';



class  ProfileScreen extends StatefulWidget {
  const  ProfileScreen({super.key});

  @override
  State< ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State< ProfileScreen> {

  Future<String?> fetchDocumentId() async {
    try {
      // Check if the user is authenticated
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is not authenticated');
        return null;
      }

      String userId = user.uid;

      // Fetch the most recent document from Firestore related to the user's userId
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('userId', isEqualTo: userId) // Filter by userId
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        print('No document found for user ID: $userId');
        return null; // Return null if no document is found
      }
    } catch (e) {
      print('Error fetching document ID: $e');
      return null;
    }
  }
  Map<String, dynamic>? _userInfo;
  final UserService _userService = UserService(); // Instantiate UserService
  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndAddress();
    _fetchUserInfo();
  }
  Future<void> _fetchUserInfo() async {
    Map<String, dynamic>? userInfo = await _userService.fetchUserInfo();
    setState(() {
      _userInfo = userInfo;
    });
  }
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
  Future<void> _refreshScreen() async {
    setState(() {
      // Trigger a rebuild of the widget tree
    });

    await fetchDocumentId(); // Example: Refetch document ID
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
      body: RefreshIndicator(
        onRefresh: _refreshScreen,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 50),
                    FutureBuilder<String?>(
                      future: fetchDocumentId(),
                      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator()); // Show loading indicator
                        } else if (snapshot.hasError) {
                          return Center(child: Icon(Icons.error)); // Show error icon
                        } else {
                          return Container(
                            width: 73,
                            height: 73,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: FittedBox(
                                fit: BoxFit.cover, // Adjust this as needed
                                child: ImageDisplayWidget(
                                  documentIdStream: Stream.value(snapshot.data),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _userInfo != null
                            ? Text(' ${_userInfo!['firstName']}',  style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),)
                            : SmallLoadingIndicator(),

                        const SizedBox(height: 4.0),
                        Container(
                          width: 151,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _userInfo != null
                              ? Text(' ${_userInfo!['email']}',   style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),)
                              : SmallLoadingIndicator(),



                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Personal Details',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Basic info',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _userInfo != null
                                ? Text('Full Name:  ${_userInfo!['firstName']} ${_userInfo!['secondName']}')
                                : SmallLoadingIndicator(),
                            SizedBox(height: 8.0),

                            Text("Address:    ${_address}"),
                            Text('Date of birth: 01/01/1999'),
                            SizedBox(height: 0),
                            _userInfo != null
                                ? Text('Contact:  ${_userInfo!['phoneNumber']} ')
                                : SmallLoadingIndicator(),

                          ],
                        ),
                        SizedBox(width: 40),

                      ],
                    ),
                    SizedBox(height: 16.0),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    Text(
                      'Pregnancy Information',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text('- Expected Due Date: September 10, 2024'),
                    Text('- Current Trimester: Second Trimester'),
                    Text('- Gestational Age: 25 weeks'),
                    Text('- Number of Pregnancies (Gravida): 2'),
                    Text('- Number of Deliveries (Para): 1'),
                    Text('- Type of Pregnancy: Single'),
                    SizedBox(height: 16.0),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    Text(
                      'Transportation Preferences',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                        'Preferred Hospital or Birthing Center: Aga Khan Hospital'),
                    Text('Preferred Mode of Transport: Ambulance'),
                    Text('Special Transportation Needs: Ambulance'),
                  ],
                ),
              ),
              const SizedBox(height: 70),
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
                        icon:
                        const Icon(Icons.home, size: 31, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  HomeScreen()),
                          );
                        },
                      ),
                      const Text('Home'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.history,
                            size: 31, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RideHistoryScreen()),
                          );
                        },
                      ),
                      const Text('History'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.account_circle,
                            size: 31, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  AccountScreen()),
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
    );
  }
}

