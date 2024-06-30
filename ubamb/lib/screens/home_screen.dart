import 'package:flutter/material.dart';
import 'package:ubamb/screens/book_ride_screen.dart';
import 'account_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    // Implement navigation drawer functionality here
                  },
                ),
                const Text(
                  'Welcome Ella!',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AccountScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 35),
            const Text(
              'Your current location',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                color: Color.fromARGB(255, 92, 92, 92),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue),
                SizedBox(width: 5),
                Text(
                  'Flamingo Estate, Nakuru',
                  style: TextStyle(
                    fontFamily: 'Hind',
                    fontSize: 20,
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
                image: const DecorationImage(
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
                MaterialPageRoute(builder: (context) => const BookRideScreen()),
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

            const Spacer(),
            const Divider(color: Colors.black, thickness: 1),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, size: 31, color: Colors.black),
                      onPressed: () {
                        // Implement home functionality here
                      },
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Home',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.history, size: 31, color: Colors.black),
                      onPressed: () {
                        // Implement history functionality here
                      },
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'History',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.person, size: 31, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AccountScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Account',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }
}