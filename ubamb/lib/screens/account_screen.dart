import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ubamb/main.dart';
import 'package:ubamb/screens/home_screen.dart';
import 'package:ubamb/screens/profile_screen.dart';
import 'package:ubamb/screens/ride_history.dart';
import 'package:ubamb/screens/settings_privacy.dart';
import 'userinfo.dart';


class AccountScreen extends StatefulWidget {


  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

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

    _fetchUserInfo();
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

    await fetchDocumentId(); // Example: Refetch document ID
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
      body: RefreshIndicator(onRefresh: _refreshScreen,
      child:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 24),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.menu, color: Colors.black, size: 23),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [FutureBuilder<String?>(
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),)
                          : SmallLoadingIndicator(),

                      const SizedBox(height: 5),
                      Container(
                        width: 139,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child:  Center(
                          child: _userInfo != null
                              ? Text(' ${_userInfo!['phoneNumber']}', style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),)
                              : SmallLoadingIndicator(),

                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: 338,
                height: 94,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Roadway Cash',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.chevron_right, color: Colors.black),
                        ],
                      ),
                      Text(
                        'Kshs 3000',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 338,
                height: 10,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              Column(


                children: [
                  GestureDetector(
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                    },
                    child:  buildMenuItem(
                      context,
                      icon: Icons.person,
                      text: 'Personal Details',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  SettingsPrivacyScreen()),
                    );
                    },
                    child:buildMenuItem(
                      context,
                      icon: Icons.settings,
                      text: 'Settings and privacy',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RideHistoryScreen()),
                    );
                    },
                    child: buildMenuItem(
                      context,
                      icon: Icons.history,
                      text: 'Trip details',
                    ),
                  ),




                ],
              ),
              const SizedBox(height: 90),
              GestureDetector(
                onTap: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
                },
                child:  Center(
                  child: Container(
                    width: 261,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Signout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 30),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home, size: 31, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  HomeScreen()),
                          );
                        },
                      ),
                      const Text('Home'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.history, size: 31, color:Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const  RideHistoryScreen()),
                          );
                        },
                      ),
                      const Text('History'),
                    ],
                  ),
                  const  Column(
                    children: [
                      Icon(Icons.account_circle, size: 31),
                      Text('Account'),
                    ],
                  ),
                ],
              ),
            ],
          ),
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

