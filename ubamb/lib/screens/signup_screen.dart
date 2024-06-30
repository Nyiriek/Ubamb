import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'code_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CA6F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
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
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 41,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 148,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'First Name',
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 148,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last Name',
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25), 
                Container(
                  width: 334,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email eg example@gmail.com',
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25), 
                Container(
                  width: 334,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25), 
                Container(
                  width: 334,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          // Add password confirmation validation logic here
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 334,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color.fromARGB(208, 1, 49, 207),
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CodeScreen(phoneNumber: '+250791701052'),
                      ),
                    );
                  },
                  child: const Text(
                    'Continue with digit code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 334,
                  height: 40,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'assets/images/google.png',
                          height: 20,
                        ),
                      ),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Colors.white,
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
      ),
    );
  }
}
