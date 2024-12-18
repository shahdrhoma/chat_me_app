import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const String id = 'WelcomePage';

  @override
  Widget build(BuildContext context) {
    // Screen size variables
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                padding: EdgeInsets.only(
                    top: screenHeight *
                        0.1), // Top padding as a percentage of screen height
                child: Image.asset(
                  'assets/images/11-48-15-802-512-unscreen.gif',
                  height: screenHeight * 0.4, // Responsive height
                  width: screenWidth * 0.8, // Responsive width
                ),
              ),
              Text(
                'Welcome to Chat Me',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: screenWidth * 0.07, // Dynamic font size
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
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              Text(
                'Connect with people, share ideas, and collaborate effortlessly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: screenWidth * 0.05, // Dynamic font size
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
              SizedBox(height: screenHeight * 0.05),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'LoginPage');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 29, 53, 77),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        screenWidth * 0.15, // Dynamic horizontal padding
                    vertical: screenHeight * 0.02, // Dynamic vertical padding
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Let\'s Chat',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Dynamic font size
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 29, 53, 77),
                  ),
                ),
              ),
              SizedBox(
                  height: screenHeight * 0.03), // Extra spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
