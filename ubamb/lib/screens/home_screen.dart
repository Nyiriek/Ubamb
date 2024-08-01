import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ubamb/screens/book_ride_screen.dart';
import 'package:ubamb/screens/ride_history.dart';
import 'account_screen.dart';
import 'userinfo.dart';
import 'dart:convert';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _userInfo;
  final UserService _userService = UserService(); // Instantiate UserService


  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndAddress();
    _fetchUserInfo();
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
        _address = 'Error: $e';
      });
    }
  }
  Future<void> _fetchUserInfo() async {
    Map<String, dynamic>? userInfo = await _userService.fetchUserInfo();
    setState(() {
      _userInfo = userInfo;
    });
  }
  Future<void> _refreshScreen() async {
    setState(() {
      // Trigger a rebuild of the widget tree
    });

    await _getCurrentLocationAndAddress(); // Example: Refetch document ID
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF4CA6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CA6F8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 34),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  _userInfo != null
            ? Text('Welcome, ${_userInfo!['firstName']}!', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
            : SmallLoadingIndicator(),

        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountScreen()),
              );
            },
          ),
        ],
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
      body: SingleChildScrollView(

       child: Padding(padding: EdgeInsets.only(left: 20, right: 20),
         child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           const SizedBox(height: 25),

           Row(
             children: [
               Icon(Icons.location_on, color: Colors.blue),
               SizedBox(width: 5),
               Text(
                 _address,
                 style: TextStyle(
                   fontFamily: 'Hind',
                   fontSize: 15,
                   fontWeight: FontWeight.bold,
                   color: Colors.black,
                 ),
               ),
               SizedBox(width: 5),
               Icon(Icons.arrow_drop_down, color: Colors.black),
             ],
           ),
           const SizedBox(height: 20),
           Container(
             width: 347,
             height: 246,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               image: DecorationImage(
                 image: AssetImage('assets/images/Group 23.png'),
                 fit: BoxFit.cover,
               ),
             ),
           ),
           const SizedBox(height: 40),
           const Text(
             'Here for you :)',
             style: TextStyle(
               fontFamily: 'Karla',
               fontSize: 40,
               color: Colors.black,
             ),
           ),
           const SizedBox(height: 35),
           GestureDetector(
             onTap: () {Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => BookRideScreen()),
             );
             },
             child:Container(
               width: 269,
               height: 48,
               decoration: BoxDecoration(
                 color: Colors.black,
                 borderRadius: BorderRadius.circular(7),
               ),
               child: const Center(
                 child: Text(
                   'Book a ride with us',
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

           const SizedBox(height: 140),
           const Divider(color: Colors.black, thickness: 1),

         ],
       ),
       )
      ),


    );
  }
}
class SmallLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 24.0, // Adjust the width as needed
        height: 24.0, // Adjust the height as needed
        child: CircularProgressIndicator(
          strokeWidth: 2.0, // Adjust the stroke width for the thickness of the indicator
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Small Loading Indicator')),
      body: SmallLoadingIndicator(),
    ),
  ));
}
