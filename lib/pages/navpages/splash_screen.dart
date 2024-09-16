import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/main_page.dart'; // Your main page
import 'package:tripwise/pages/welcome_page.dart';

import '../welcome_page.dart'; // Your welcome page

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Simulate a delay for the splash screen, e.g., 3 seconds
    await Future.delayed(Duration(seconds: 3));

    // Check if a user is logged in
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Navigate to the appropriate page
    if (currentUser != null) {
      // User is logged in, navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage(initialIndex: 0, user: currentUser)),
      );
    } else {
      // User is not logged in, navigate to welcome page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()), // Replace with your welcome page
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo
            Image.asset('assets/logo.png', height: 150), // Replace with your logo
            SizedBox(height: 20),
            CircularProgressIndicator(), // Loading circle
          ],
        ),
      ),
    );
  }
}
