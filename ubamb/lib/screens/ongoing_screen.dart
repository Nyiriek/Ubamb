import 'package:flutter/material.dart';
import 'package:ubamb/screens/account_screen.dart';
import 'package:ubamb/screens/arrived_screen.dart';
import 'package:ubamb/screens/home_screen.dart';
import 'package:ubamb/screens/maps4.dart';
import 'package:ubamb/screens/ride_history.dart';


class OngoingScreen extends StatefulWidget {
  const OngoingScreen({super.key});

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
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
        title: Text('Your ride has started ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),),
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
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


              const Padding(padding: EdgeInsets.only(left: 140),
                child: Text('Ongoing trip ',
                  style: TextStyle(
                    color: Color(0xFF01AD1F),
                    fontSize: 20,
                  ),),),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 450,
                      child: MapsScreen1(),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 35),
              Padding(padding: const EdgeInsets.only(left: 60),
                child:  Row(
                  children: [
                    const SizedBox(width: 70),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArrivedScreen()),
                        );
                      },
                      child: Container(
                        width: 128,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(7),
                        ),

                        child: const Center(
                          child: Text(
                            'Arrived?',
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

