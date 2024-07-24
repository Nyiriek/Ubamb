import 'package:flutter/material.dart';
import 'package:ubamb/screens/arrived_screen.dart';

class OngoingScreen extends StatelessWidget {
  const OngoingScreen({super.key});

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
              const SizedBox(height: 55),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.black, size: 34),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 55),
                  const Text('Your ride has started ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                  ),),
                ],
              ),
              const Padding(padding: EdgeInsets.only(left: 140, top: 30),
              child: Text('Ongoing trip ',
                style: TextStyle(
                  color: Color(0xFF01AD1F),
                  fontSize: 20,
                ),),),
              const SizedBox(height: 20),
              Stack(
               children: [
                 Positioned(
                   child: SizedBox(
                     width: MediaQuery.of(context).size.width,
                     height: 600,
                     child: Image.asset(
                       'assets/images/img_14.png',
                       width: MediaQuery.of(context).size.width,
                       fit: BoxFit.cover,
                     ),
                   ),
                 ),
                 Positioned(
                   top: 50,
                   left: 20,
                   child: SizedBox(
                     width: MediaQuery.of(context).size.width,
                     height: 400,
                     child: Image.asset(
                       'assets/images/img_15.png',
                       width: MediaQuery.of(context).size.width,
                       fit: BoxFit.cover,
                     ),
                   ),
                 ),
               ],
              ),

              const SizedBox(height: 35),
             Padding(padding: const EdgeInsets.only(left: 60),
              child:  Row(
                children: [
                  const SizedBox(width: 70),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ArrivedScreen()),
                      );
                    },
                    child: Container(
                      width: 128,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7),
                      ),

                      child: const Center(
                        child: Text(
                          'OK',
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
                ],
              ),
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
