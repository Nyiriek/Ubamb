import 'package:flutter/material.dart';

import 'package:ubamb/screens/rating_screen.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              const SizedBox(height: 10, width: 30),
             const Padding(padding: EdgeInsets.only(left: 30),
             child:  Text(
               'Wallet',
               style: TextStyle(
                 fontSize: 32,
                 fontWeight: FontWeight.bold,
                 color: Colors.black,
               ),
             ),
             ),
             const SizedBox(height: 10),
              Padding(padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 370,
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

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),

                              Text(
                                'Roadway Cash',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),

                              Text(
                                'Kshs 3000',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF54575E),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 190),
                          Icon(Icons.chevron_right, color: Colors.black),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              ),

              const SizedBox(height: 20),
             const Padding(padding: EdgeInsets.only(left: 10),
             child:  Text(
               'Topup your cash', style: TextStyle(
               color: Colors.black,
               fontSize: 20,
             ),
             ),
             ),
              Column(
                children: [
                    Row(
                      children: [
                        const SizedBox(height: 40, width: 30),

                        Text(
                          'Pay with', style: TextStyle(
                          color: Colors.blueGrey[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(height: 40, width: 30),

                      Image.asset(
                        'assets/images/img_9.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 20),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),

                          Text(
                            'Debit card',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),

                          Text(
                            'Accepting Visa, Mastercard, etc',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF54575E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 60),
                      Image.asset(
                        'assets/images/img_3.png',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(height: 40, width: 30),

                      Image.asset(
                        'assets/images/img_8.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 20),
                     const Text(
                       'Google Pay',
                       style: TextStyle(
                         fontSize: 16,

                         color: Colors.black,
                       ),
                     ),
                      const SizedBox(width: 173),
                      Image.asset(
                        'assets/images/img_3.png',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
             const Divider(
                color: Colors.white,
                thickness: 2,

              ),
              const SizedBox(height: 10),
              const Padding(padding: EdgeInsets.only(left: 20),

              child: Text(
                'Add manual payments',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ),
              const SizedBox(height: 10),
              Padding(padding: const EdgeInsets.only(left: 10),
                child: Container(
                  width: 370,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            const Text(
                              'Add new',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 200),
                            Image.asset(
                              'assets/images/img_3.png',
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/images/img_10.png',
                              width: 35,
                              height: 35,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'PayPal',
                              style: TextStyle(
                                color:Color(0xFF776F6F),
                                fontSize: 20,

                              ),
                            ),
                            const SizedBox(width: 175),
                            Image.asset(
                              'assets/images/img_12.png',
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/images/img_13.png',
                              width: 80,
                              height: 50,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'MomoPay',
                              style: TextStyle(
                                color:Color(0xFF776F6F),
                                fontSize: 20,

                              ),
                            ),
                            const SizedBox(width: 100),
                            Image.asset(
                              'assets/images/img_12.png',
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RatingScreen()),
                );
                },
                child:  Center(
                  child: Container(
                    width: 158.81,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Done',
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
