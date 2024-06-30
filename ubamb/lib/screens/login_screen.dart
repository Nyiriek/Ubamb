import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 35),
              Container(
                width: 150,
                height: 51,
                margin: const EdgeInsets.only(bottom: 15),
                alignment: Alignment.center,
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 41,
                    fontFamily: 'Hind Jalandhar',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 314,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'username eg email',
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 314,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Container(
                  width: 142,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Hind Jalandhar',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color.fromARGB(208, 1, 49, 207),
                        fontSize: 20,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'OR',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 314,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset(
                        'assets/images/google.png',
                        height: 25,
                      ),
                    ),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
}
