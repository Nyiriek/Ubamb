import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
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
        title: const Text('Rating', style: TextStyle(color: Colors.black)),
        elevation: 0,
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
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            size: 40,
                            color: Colors.black,
                          );
                        }),
                      ),
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
                      children: List.generate(_issues.length, (index) {
                        return FilterChip(
                          label: Text(_issues[index]),
                          selected: _selectedIssues[index],
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedIssues[index] = selected;
                            });
                          },
                          backgroundColor: Colors.blue[300],
                          selectedColor: Colors.blue[500],
                          labelStyle: const TextStyle(color: Colors.black),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please Select one or more issues.',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        // Handle submit
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}