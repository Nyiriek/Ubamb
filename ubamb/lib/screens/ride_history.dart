import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'account_screen.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

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
        title: Text(
          'Ride History',
          style: TextStyle(
            fontFamily: 'Roboto Regular',
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Aga Khan Hospital, Nairobi',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Kshs 200',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.zoom_in, color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Aga Khan Hospital',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    'Jan 8, 2022 - 3:33',
                    style: TextStyle(
                      color: Color(0xFF444646),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Color(0xFFC5C5C5),
                thickness: 2,
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Aga Khan Hospital, Nairobi',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Kshs 180',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.zoom_in, color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Aga Khan Hospital',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    'Jan 30, 2022 - 2:33',
                    style: TextStyle(
                      color: Color(0xFF444646),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Color(0xFFC5C5C5),
                thickness: 2,
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Aga Khan Hospital, Nairobi',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Kshs 220',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.zoom_in, color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Aga Khan Hospital',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    'March 8, 2022 - 6:33',
                    style: TextStyle(
                      color: Color(0xFF444646),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Color(0xFFC5C5C5),
                thickness: 2,
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Aga Khan Hospital, Nairobi',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Kshs 250',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.zoom_in, color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Aga Khan Hospital',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    'May 8, 2022 - 3:00',
                    style: TextStyle(
                      color: Color(0xFF444646),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Color(0xFFC5C5C5),
                thickness: 2,
              ),
              const SizedBox(height: 65),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),

            ],
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
