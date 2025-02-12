import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ubamb/screens/book_ride_screen.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final int _rating = 4;
  bool _isSelected = false;
  bool _issSelected = false;
  bool _isssSelected = false;
  bool _issssSelected = false;
  bool _isssssSelected = false;
  bool _issssssSelected = false;
  String _statusMessage = '';

  Future<void> _saveRatingAndIssues() async {
    final User? user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user == null) {
      // Handle the case where there's no logged-in user
      setState(() {
        _statusMessage = 'User not logged in.';
      });
      return;
    }

    final String userId = user.uid; // Get the user ID
    final CollectionReference ratings = FirebaseFirestore.instance.collection('ratings');

    try {
      await ratings.add({
        'userId': userId, // Include the userId in the data
        'rating': _rating,
        'issues': [
          if (_isSelected) 'Poor Route',
          if (_isssSelected) 'Too many Pickups',
          if (_issSelected) 'Co-rider behavior',
          if (_issssSelected) 'Navigation',
          if (_isssssSelected) 'Driving',
          if (_issssssSelected) 'Other',
        ],
        'timestamp': FieldValue.serverTimestamp(),
      });
      setState(() {
        _statusMessage = 'Rating saved successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error saving rating: $e';
      });
    }
  }

  @override
  void dispose() {
    // Cancel any timers or stop any animations here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4CA6F8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Rating', style: TextStyle(color: Colors.black)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF4CA6F8),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    RatingPage(),
                    const Divider(
                      color: Color(0xFFC5C5C5),
                      thickness: 2,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'What went wrong?',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          Column(
                            children: [
                              Container(
                                child: FilterChip(
                                  label: Text('Poor Route'),
                                  selected: _isSelected,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _isSelected = selected;
                                    });
                                  },
                                  backgroundColor: Color(0xFF2896F9),
                                  selectedColor: Color(0xFF4CA6F8),
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: Color(0xFF4CA6F8),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: FilterChip(
                                  label: Text('Too many Pickups'),
                                  selected: _isssSelected,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _isssSelected = selected;
                                    });
                                  },
                                  backgroundColor: Color(0xFF2896F9),
                                  selectedColor: Color(0xFF4CA6F8),
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 13),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: Color(0xFF4CA6F8),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: FilterChip(
                                  label: Text('Co-rider behavior'),
                                  selected: _issSelected,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _issSelected = selected;
                                    });
                                  },
                                  backgroundColor: Color(0xFF2896F9),
                                  selectedColor: Color(0xFF4CA6F8),
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 13),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: Color(0xFF4CA6F8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Column(
                            children: [
                              Container(
                                child: FilterChip(
                                  label: Text('Navigation'),
                                  selected: _issssSelected,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _issssSelected = selected;
                                    });
                                  },
                                  backgroundColor: Color(0xFF2896F9),
                                  selectedColor: Color(0xFF4CA6F8),
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: Color(0xFF4CA6F8),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: FilterChip(
                                  label: Text('Driving'),
                                  selected: _isssssSelected,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _isssssSelected = selected;
                                    });
                                  },
                                  backgroundColor: Color(0xFF2896F9),
                                  selectedColor: Color(0xFF4CA6F8),
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 13),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 34, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: Color(0xFF4CA6F8),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: FilterChip(
                                  label: Text('Other'),
                                  selected: _issssssSelected,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _issssssSelected = selected;
                                    });
                                  },
                                  backgroundColor: Color(0xFF4CA6F8),
                                  selectedColor: Color(0xFF4CA6F8),
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 13),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 38, vertical: 4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: Color(0xFF4CA6F8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please Select one or more issues.',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                    const SizedBox(height: 100),
                    GestureDetector(
                      onTap: () async {
                        // _saveRatingAndIssues();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookRideScreen()),
                        );
                      },
                      child: Container(
                        width: 324,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: 'Roboto Medium',
                              fontSize: 18,
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
            ),
          ],
        ),
      ),
    );
  }
}

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int _rating = 0;

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  String _getRatingText(int rating) {
    if (rating <= 1) return 'Bad';
    if (rating == 2 || rating == 3) return 'Good';
    return 'Excellent';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _getRatingText(_rating),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => _setRating(index + 1),
                child: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  size: 40,
                  color: index < _rating ? Colors.black : Colors.grey,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
