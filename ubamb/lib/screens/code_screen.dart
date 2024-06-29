import 'package:flutter/material.dart';

class CodeScreen extends StatelessWidget {
  final String phoneNumber;

  const CodeScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Enter the 6 digit code sent to $phoneNumber',
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return Container(
                  width: 52,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto',
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Container(
              width: 184,
              height: 39,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Center(
                child: Text(
                  "I didn't receive a code",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Implement the resend code functionality here
              },
              child: const Text(
                'Resend code',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Expanded(child: SizedBox()), // Expanded to push the back arrow to the bottom
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
