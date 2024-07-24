import 'package:flutter/material.dart';
import 'package:ubamb/screens/account_screen.dart';
import 'package:ubamb/screens/home_screen.dart';
import 'package:ubamb/screens/ride_history.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

        //
        // title: const Text('Ella'),
        // centerTitle: true,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: CircleAvatar(
        //       backgroundColor: Colors.grey,
        //       child: Icon(Icons.person, color: Colors.white),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  const SizedBox(width: 50),
                  const CircleAvatar(
                    radius: 30.0, // Adjust the radius as needed
                    backgroundColor:
                        Colors.grey, // Set the background color of the circle
                    child: Icon(
                      Icons.person, // Set the icon to display
                      size: 50.0, // Adjust the size of the icon as needed
                      color: Color(0xFF4CA6F8), // Set the color of the icon
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ella',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        width: 151,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'ellapeter@gmail.com',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Column(
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
                          Text('Full Name: Ella Peter'),
                          SizedBox(height: 8.0),
                          Text('Address:'),
                          Text('456 Ngong Road'),
                          Text('Nairobi, Kenya'),
                        ],
                      ),
                      SizedBox(width: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 0),
                          Text('Date of birth: 01/01/1999'),
                          SizedBox(height: 20),
                          Text('Contact: 25479378950'),
                        ],
                      ),
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
                              builder: (context) => const HomeScreen()),
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
                              builder: (context) => const AccountScreen()),
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
    );
  }
}
