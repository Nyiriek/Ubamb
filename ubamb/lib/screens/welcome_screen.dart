import 'package:flutter/material.dart';
import 'package:ubamb/screens/arrived_screen.dart';
import 'package:ubamb/screens/book_ride_screen.dart';
import 'package:ubamb/screens/maps.dart';
import 'package:ubamb/screens/maps2.dart';
import 'package:ubamb/screens/maps5.dart';
import 'package:ubamb/screens/signup_screen.dart';
import 'package:url_launcher/url_launcher.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UBAMB',
      home: UBAMB(),
    );
  }
}

class UBAMB extends StatefulWidget {
  const UBAMB({super.key});

  @override
  _UBAMBState createState() => _UBAMBState();
}

class _UBAMBState extends State<UBAMB> {
  String _selectedCountryCode = '+254';
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showError = false;

  final List<Map<String, String>> _countryCodes = [
    {'code': '+211', 'flag': 'assets/images/ssd.png'},
    {'code': '+250', 'flag': 'assets/images/rwanda.png'},
    {'code': '+256', 'flag': 'assets/images/uganda.png'},
    {'code': '+254', 'flag': 'assets/images/flag.png'},
    {'code': '+243', 'flag': 'assets/images/congo.png'},
    {'code': '+257', 'flag': 'assets/images/burundi.png'},
    {'code': '+251', 'flag': 'assets/images/ethiopia.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'UBAMB',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: 390,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/amb.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          const Color(0xFF4CA6F8).withOpacity(0.5),
                          BlendMode.srcATop,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter your mobile number',
                      style: TextStyle(
                        color: Color.fromARGB(255, 6, 47, 160),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCountryCode,
                            items: _countryCodes.map((Map<String, String> country) {
                              return DropdownMenuItem<String>(
                                value: country['code'],
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      country['flag']!,
                                      height: 30,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      country['code']!,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCountryCode = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    controller: _phoneNumberController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '79#######',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        setState(() {
                                          _showError = true;
                                        });
                                        return null;
                                      } else {
                                        setState(() {
                                          _showError = false;
                                        });
                                        return null; 
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            if (_showError)
                              const Positioned(
                                top: 41,
                                left: 5,
                                child: Text(
                                  'Field is required and must be 9 digits',
                                  style: TextStyle(color: Color.fromARGB(255, 179, 13, 1), fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: 370,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && !_showError) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                  const SizedBox(height: 20),

                  Container(
                    width: 370,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        const emergencyNumber = 'tel:211'; 
                        if (await canLaunch(emergencyNumber)) {
                          await launch(emergencyNumber);
                        } else {
                          throw 'Could not launch $emergencyNumber';
                        }
                      },
                      child: const Center(
                        child: Text(
                          'EMERGENCY CALL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
