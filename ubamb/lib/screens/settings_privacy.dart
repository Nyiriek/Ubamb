import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import 'package:ubamb/screens/account_screen.dart';
import 'package:ubamb/screens/home_screen.dart';
import 'package:ubamb/screens/ride_history.dart';
import 'userinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class SettingsPrivacyScreen extends StatefulWidget {

  @override
  State<SettingsPrivacyScreen> createState() => _SettingsPrivacyScreenState();
}

class _SettingsPrivacyScreenState extends State<SettingsPrivacyScreen> {

  BehaviorSubject<String?> documentIdSubject = BehaviorSubject<String?>();
  Stream<String?> get documentIdStream => documentIdSubject.stream;


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
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImage(_image!);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      // Check if the user is authenticated
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is not authenticated');
        return null;
      }

      String userId = user.uid;
      print('Authenticated user ID: $userId');

      // Upload the image to Firebase Storage
      firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      firebase_storage.UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask;

      String downloadURL = await storageReference.getDownloadURL();
      print('Image uploaded to Firebase Storage with URL: $downloadURL');

      // Store the image metadata in Firestore
      DocumentReference docRef = await FirebaseFirestore.instance.collection('images').add({
        'url': downloadURL,
        'timestamp': FieldValue.serverTimestamp(), // Use server timestamp for consistency
        'userId': userId, // Ensure this field is included
      });

      print('Image metadata stored in Firestore with document ID: ${docRef.id}');

      // Return the document ID of the newly uploaded image
      return docRef.id;
    } on FirebaseException catch (e) {
      print('Firebase error uploading image: ${e.message}');
      return null;
    } catch (e) {
      print('General error uploading image: $e');
      return null;
    }
  }
  String? documentId;

  Future<void> uploadAndDisplayImage(File imageFile) async {
    documentId = await _uploadImage(imageFile);
    // No need to add to a stream, just update the UI
  }

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
      body: RefreshIndicator(
        onRefresh: _refreshScreen,
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
              Row(

                children: [
                  IconButton(
                    icon:  const Icon(Icons.arrow_back,
                        color: Colors.black, size: 35),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(left: 30),
                    child: Text('Settings and Privacy', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: FutureBuilder<String?>(
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
                      ),
                      Positioned(
                        top: 35,
                        left: 30,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.edit, color: Colors.black, size: 30),
                            onPressed: _pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_userInfo != null)
                        Text(
                          ' ${_userInfo!['firstName']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      const SizedBox(height: 5),
                      Container(
                        width: 139,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Center(
                          child: _userInfo != null
                              ? Text(
                            ' ${_userInfo!['phoneNumber']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          )
                              : SmallLoadingIndicator(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Edit personal details", style: TextStyle(color: Colors.black, fontSize: 25, decoration: TextDecoration.underline, fontWeight: FontWeight.bold ),),
                      SizedBox(width: 5),
                      Icon(Icons.edit, color: Colors.black, size: 20),
                    ],
                  ),

                  Padding(padding: const EdgeInsets.only(left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Full Name:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Ella James',
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Date of birth:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '01/01/1999',
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Contact:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '25479378950',
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Address:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: ' 456 Ngong Road, Nairobi, Kenya',
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Text("Edit transportation preferences", style: TextStyle(color: Colors.black, fontSize: 20, decoration: TextDecoration.underline , fontWeight: FontWeight.bold),),
                            SizedBox(width: 5),
                            Icon(Icons.edit, color: Colors.black, size: 20),

                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text("Preferred Hospital or Birthing Center:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Aga Khan Hospital',
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Preferred Mode of Transport:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Ambulance',
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Special Transportation Needs:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Ambulance',
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
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


              const SizedBox(height: 30),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              const SizedBox(height: 5),
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
                  Column(
                    children: [
                      IconButton(
                        icon:  const Icon(Icons.account_circle, size: 31, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>   AccountScreen()),
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

class ImageDisplayWidget extends StatefulWidget {
  final Stream<String?> documentIdStream;

  ImageDisplayWidget({required this.documentIdStream});

  @override
  _ImageDisplayWidgetState createState() => _ImageDisplayWidgetState();
}

class _ImageDisplayWidgetState extends State<ImageDisplayWidget> {
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


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: widget.documentIdStream,
      builder: (BuildContext context, AsyncSnapshot<String?> documentIdSnapshot) {
        if (documentIdSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator
        } else if (documentIdSnapshot.hasError || documentIdSnapshot.data == null) {
          return Center(child: Container(
            width: 73,
            height: 73,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: _userInfo != null
                ? Text(' ${_userInfo!['firstName'][0]}', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ))
                : CircularProgressIndicator(),
          ),); // Show error icon
        } else {
          String? documentId = documentIdSnapshot.data;
          if (documentId == null) {
            return Center(child: Text('No Image Uploaded')); // Placeholder for no image
          }

          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('images').doc(documentId).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator()); // Show loading indicator
              } else if (snapshot.hasError) {
                return Center(child: Icon(Icons.person)); // Show error icon
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(child:Container(
                  width: 73,
                  height: 73,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: _userInfo != null
                      ? Text(' ${_userInfo!['firstName'][0]}', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ))
                      : CircularProgressIndicator(),
                ),); // Show placeholder if no image found
              } else {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                String imageUrl = data['url']; // Assuming the image URL is stored under 'url'
                return Center(child: Image.network(imageUrl));
              }
            },
          );
        }
      },
    );
  }
}