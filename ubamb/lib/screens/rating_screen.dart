import 'package:flutter/material.dart';
import 'package:ubamb/screens/book_ride_screen.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final int _rating = 4;
  final List<String> _issues = [
    'Poor Route',
    'Too many Pickups',
    'Co-rider behavior',
    'Navigation',
    'Driving',
    'Other'
  ];
  final List<bool> _selectedIssues = List.generate(6, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:  Text('Rating', style: TextStyle(color: Colors.black)),
        elevation: 0,
        centerTitle: true ,
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
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
                          Text('Good',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < _rating ? Icons.star : Icons.star_border,
                                size: 40,
                                color: Colors.black,
                              );
                            },
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 50),
                            Column(
                              children: List.generate(_issues.length ~/ 2, (index) {
                                final issueIndex = index * 2 ;
                                if (issueIndex >= _issues.length) {
                                  return const SizedBox.shrink();
                                }
                                return FilterChip(
                                  label: Text(_issues[issueIndex]),
                                  selected: _selectedIssues[issueIndex],
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _selectedIssues[issueIndex] = selected;
                                    });
                                  },
                                  backgroundColor: Colors.blue[300],
                                  selectedColor: Colors.blue[500],
                                  labelStyle: const TextStyle(color: Colors.black),
                                );
                              }),
                            ),
                            SizedBox(width: 30),
                            Column(
                              children: List.generate(_issues.length ~/ 2, (index) {
                                final issueIndex = index * 2 + 1;
                                if (issueIndex >= _issues.length) {
                                  return const SizedBox.shrink();
                                }
                                return SizedBox(
                                  height: 40,
                                  width: 180,// Set the desired height for all FilterChips
                                  child: FilterChip(
                                    label: Text(_issues[issueIndex]),
                                    selected: _selectedIssues[issueIndex],
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _selectedIssues[issueIndex] = selected;
                                      });
                                    },
                                    backgroundColor: Colors.blue[300],
                                    selectedColor: Colors.blue[500],
                                    labelStyle: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }),
                            ),

                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please Select one or more issues.',
                      style: TextStyle(color: Colors.black54, fontSize: 20,),
                    ),
                    const SizedBox(height: 100),
                    GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookRideScreen()),
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
            // BottomNavigationBar(
            //   items: const [
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            //     BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
            //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}