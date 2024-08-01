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
  final TextEditingController _dateController = TextEditingController();
  final UserService1 _userService1 = UserService1();
  final _fullNameController = TextEditingController();
  TextEditingController _dueDateController = TextEditingController();
  final _phoneCallNumberController = TextEditingController();
  final _addressLocationController = TextEditingController();
  final _preferredHospitalController = TextEditingController();
  final _modeOfTransportController = TextEditingController();
  final _trimesterController = TextEditingController();
  final _gestationalController = TextEditingController();
  final _pregnanciesController = TextEditingController();
  final _deliveriesController = TextEditingController();
  final _typeController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _dateController.dispose();
    _phoneCallNumberController.dispose();
    _addressLocationController.dispose();
    _preferredHospitalController.dispose();
    _modeOfTransportController.dispose();
    _dueDateController.dispose();
    _trimesterController.dispose();
    _gestationalController.dispose();
    _pregnanciesController.dispose();
    _deliveriesController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  Future<void> _loadUserInfo() async {
    Map<String, dynamic>? userInfo = await _userService1.fetchUserInfo();
    if (userInfo != null) {
      _fullNameController.text = userInfo['fullName'];
      _dateController.text = userInfo['dateOfBirth'];
      _phoneCallNumberController.text = userInfo['phoneCallNumber'];
      _addressLocationController.text = userInfo['addressLocation'];
      _preferredHospitalController.text = userInfo['preferredHospital'];
      _modeOfTransportController.text = userInfo['modeOfTransport'];
      _dueDateController.text = userInfo['dueDate'];
      _trimesterController.text = userInfo['currentTrimester'];
      _gestationalController.text = userInfo['gestationalAge'];
      _pregnanciesController.text = userInfo['numberOfPregnancies'];
      _deliveriesController.text = userInfo['numberOfDeliveries'];
      _typeController.text = userInfo['typeOfPregnancy'];

    }
  }

  Future<void> _saveSettings() async {
    await _userService1.storeUserInfo(
      _fullNameController.text,
      _dateController.text,
      _phoneCallNumberController.text,
      _addressLocationController.text,
      _preferredHospitalController.text,
      _modeOfTransportController.text,
        _dueDateController.text,
        _trimesterController.text ,
    _gestationalController.text ,
    _pregnanciesController.text ,
    _deliveriesController.text ,
    _typeController.text ,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings saved successfully!')),
    );
  }
  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndAddress();
    _fetchUserInfo();
    _loadUserInfo();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];

      });
  }
  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        _dueDateController.text =  "${picked.toLocal()}".split(' ')[0];
      });
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CA6F8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 34),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Settings and Privacy',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
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
      body: RefreshIndicator(
        onRefresh: _refreshScreen,
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),


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
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                controller: _fullNameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _userInfo != null
                                      ? '${_userInfo!['firstName']} ${_userInfo!['secondName']}'
                                      : '',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                // Makes the field non-editable
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(

                              controller: _dateController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '2024-07-04',
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () => _selectDate(context),
                                ),
                              ),
                              readOnly: true, // Prevents the user from editing the text directly
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
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _phoneCallNumberController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:_userInfo != null ? _userInfo!['phoneNumber'] : '',
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
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _addressLocationController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _address,
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
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _preferredHospitalController,
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
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _modeOfTransportController,
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
                        const Text("Expected Due Date:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _dueDateController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '2024-07-04',

                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () => _selectDueDate(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),const SizedBox(height: 10),
                        const Text("Current Trimester:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _trimesterController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Second Trimester',

                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),const SizedBox(height: 10),
                        const Text("Gestational Age:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _gestationalController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '25 Weeks',

                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),const SizedBox(height: 10),
                        const Text("Number of Pregnancies(Gravida):", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _pregnanciesController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '2',

                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ), const SizedBox(height: 10),
                        const Text("Number of Deliveries(Para):", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _deliveriesController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '1',

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
                        const Text("Type of Pregnancy:", style: TextStyle(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 2),
                        Container(
                          width: 307,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,

                          ),
                          child:  Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: _typeController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Single',

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
                  Padding(padding: EdgeInsets.only(left: 100,top: 40 ),
                  child:ElevatedButton(
                    onPressed: () async {
                      await _saveSettings(); // Save the information to Firestore
                      Navigator.pop(context); // Navigate back to the previous screen (AccountScreen)
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Set the background color to blue
                      foregroundColor: Colors.white, // Set the text color to white
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Customize padding
                      textStyle: TextStyle(fontSize: 18), // Customize text style
                    ),
                    child: Text('Save'),
                  ),

                  )
                ],

              ),


              const SizedBox(height: 30),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              const SizedBox(height: 5),


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


class UserService1 {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> storeUserInfo(String fullName, String dateOfBirth, String phoneCallNumber, String addressLocation, String preferredHospital, String modeOfTransport, String dueDate, String currentTrimester, String gestationalAge,String numberOfPregnancies, String numberOfDeliveries, String typeOfPregnancy) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('usersSettings').doc(user.uid).set({
        'fullName': fullName,
        'dateOfBirth': dateOfBirth,
        'phoneCallNumber': phoneCallNumber,
        'addressLocation': addressLocation,
        'prefferedHospital': preferredHospital,
        'modeOfTransport': modeOfTransport,
        'dueDate': dueDate,
        'currentTrimester': currentTrimester,
        'gestationalAge': gestationalAge,
        'numberOfPregnancies':numberOfPregnancies,
        'numberOfDeliveries': numberOfDeliveries,
        'typeOfPregnancy': typeOfPregnancy


        // Add other fields as needed
      });
    }
  }

  Future<Map<String, dynamic>?> fetchUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot documentSnapshot = await _firestore.collection('usersSettings').doc(user.uid).get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      }
    }
    return null;
  }

}
