import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'account_screen.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Padding(padding: EdgeInsets.only(left: -0),
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
              const SizedBox(height:30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Padding(padding: EdgeInsets.only(left: 30),
                     child: Icon(Icons.location_on, color: Colors.black, size: 30),
                   ),
                  const SizedBox(width:10),
                  Text('Aga Khan Hospital, Nairobi',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width:15),
                  Text('Kshs 200',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height:10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 33),
                    child:  Icon(Icons.zoom_in, color: Colors.black, size: 30),
                  ),

                  const SizedBox(width:10),
                  Text('Aga Khan Hospital',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 10),
              const Row(
                children: [
                 Padding(padding: EdgeInsets.only(left: 35),
                   child: Text(
                       'Jan 8, 2022 - 3:33',
                       style: TextStyle(
                         color: Color(0xFF444646),
                         fontSize: 20,
                       ),
                   ),
                 ),
                ],
              ),

              const Divider(
                color: Color(0xFFC5C5C5),
                thickness: 2,
              ),
              const SizedBox(height:10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 30),
                    child: Icon(Icons.location_on, color: Colors.black, size: 30),
                  ),
                  const SizedBox(width:10),
                  Text('Aga Khan Hospital, Nairobi',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width:15),
                  Text('Kshs 180',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height:10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 33),
                    child:  Icon(Icons.zoom_in, color: Colors.black, size: 30),
                  ),

                  const SizedBox(width:10),
                  Text('Aga Khan Hospital',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 10),
              const Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 35),
                    child: Text(
                      'Jan 30, 2022 - 2:33',
                      style: TextStyle(
                        color: Color(0xFF444646),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(
                color: Color(0xFFC5C5C5),
                thickness: 2,
              ),
              const SizedBox(height:10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 30),
                    child: Icon(Icons.location_on, color: Colors.black, size: 30),
                  ),
                  const SizedBox(width:10),
                  Text('Aga Khan Hospital, Nairobi',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width:15),
                  Text('Kshs 220',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height:10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 33),
                    child:  Icon(Icons.zoom_in, color: Colors.black, size: 30),
                  ),

                  const SizedBox(width:10),
                  Text('Aga Khan Hospital',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 10),
              const Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 35),
                    child: Text(
                      'March 8, 2022 - 6:33',
                      style: TextStyle(
                        color: Color(0xFF444646),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(
                color: Color(0xFFC5C5C5),
                thickness: 2,
              ),
              const SizedBox(height:10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 30),
                    child: Icon(Icons.location_on, color: Colors.black, size: 30),
                  ),
                  const SizedBox(width:10),
                  Text('Aga Khan Hospital, Nairobi',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width:15),
                  Text('Kshs 250',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height:10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 33),
                    child:  Icon(Icons.zoom_in, color: Colors.black, size: 30),
                  ),

                  const SizedBox(width:10),
                  Text('Aga Khan Hospital',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 10),
              const Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 35),
                    child: Text(
                      'May 8, 2022 - 3:00',
                      style: TextStyle(
                        color: Color(0xFF444646),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(
                color: Color(0xFFC5C5C5),
                thickness: 2,
              ),
              const SizedBox(height: 100),
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
                        icon:  Icon(Icons.home, size: 31, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        },
                      ),
                      const Text('Home'),
                    ],
                  ),
                  const Column(
                    children: [
                      Icon(Icons.history, size: 31),
                      const SizedBox(height: 7),
                      Text('History'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon:  const Icon(Icons.account_circle, size: 31, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AccountScreen()),
                          );
                        },
                      ),
                      Text('Account'),
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
