import 'package:flutter/material.dart';
import 'package:ubamb/screens/account_screen.dart';
import 'package:ubamb/screens/home_screen.dart';
import 'package:ubamb/screens/ride_history.dart';

class SettingsPrivacyScreen extends StatelessWidget {
  const SettingsPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
              Row(

                children: [
                  IconButton(
                    icon:  Icon(Icons.arrow_back,
                        color: Colors.black, size: 35),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.only(left: 30),
                  child: Text('Settings and Privacy', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(padding: EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Stack(
                    children:[
                      Positioned(
                        child:
                        Container(
                          width: 73,
                          height: 73,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/user 1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 45,
                        left: 40,
                        child:
                        Container(

                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),


                            child: Icon(Icons.edit, color: Colors.black, size: 30)
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ella',
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
                        child: const Center(
                          child: Text(
                            '+250791701052',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Edit personal details", style: TextStyle(color: Colors.black, fontSize: 25, decoration: TextDecoration.underline, fontWeight: FontWeight.bold ),),
                      SizedBox(width: 5),
                      Icon(Icons.edit, color: Colors.black, size: 20),
                    ],
                  ),

                  Padding(padding: EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Full Name:", style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 2),
                      Container(
                        width: 307,
                        height: 40,
                        decoration: BoxDecoration(
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
                      SizedBox(height: 10),
                      Text("Date of birth:", style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 2),
                      Container(
                        width: 307,
                        height: 40,
                        decoration: BoxDecoration(
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
                      SizedBox(height: 10),
                      Text("Contact:", style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 2),
                      Container(
                        width: 307,
                        height: 40,
                        decoration: BoxDecoration(
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
                      SizedBox(height: 10),
                      Text("Address:", style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 2),
                      Container(
                        width: 307,
                        height: 40,
                        decoration: BoxDecoration(
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
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text("Edit transportation preferences", style: TextStyle(color: Colors.black, fontSize: 25, decoration: TextDecoration.underline , fontWeight: FontWeight.bold),),
                          SizedBox(width: 5),
                          Icon(Icons.edit, color: Colors.black, size: 20),

                        ],
                      ),
                      SizedBox(height: 10),
                      Text("Preferred Hospital or Birthing Center:", style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 2),
                      Container(
                        width: 307,
                        height: 40,
                        decoration: BoxDecoration(
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
                      SizedBox(height: 10),
                      Text("Preferred Mode of Transport:", style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 2),
                      Container(
                        width: 307,
                        height: 40,
                        decoration: BoxDecoration(
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
                      SizedBox(height: 10),
                      Text("Special Transportation Needs:", style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 2),
                      Container(
                        width: 307,
                        height: 40,
                        decoration: BoxDecoration(
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
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
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
                        icon:  Icon(Icons.account_circle, size: 31, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const  AccountScreen()),
                          );
                        },
                      ),

                      Text('Account'),
                    ],
                  ),
                ],
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














