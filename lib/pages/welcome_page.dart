import 'package:chats_project/constants.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const String id = 'WelcomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 53, 77), // Background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Image.asset(
                  'assets/images/11-48-15-802-512-unscreen.gif',
                  height: 400,
                  width: 400,
                ),
              ),
              Text(
                'Welcome to Chat Me ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 36, // Increased font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Strong contrast color
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Connect with people, share ideas, and collaborate effortlessly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 22, // Increased font size
                  fontWeight: FontWeight.bold, // Slightly bold text
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 8.0,
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'LoginPage');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 29, 53, 77),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Let\'s Chat',
                  style: TextStyle(
                    fontSize: 20, // Increased font size
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 29, 53, 77),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Extra spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
