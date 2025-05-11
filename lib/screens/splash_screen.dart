import 'package:flutter/material.dart';

import '../utils/routing/routes_name.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 2)); // Show the splash screen for 3 seconds
    Navigator.pushReplacementNamed(context, RouteName.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white, // Background color for the splash screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/clipwise-icon.png',
              width: 150, // Adjust width
              height: 150, // Adjust height
              fit: BoxFit.contain, // Ensures the image is displayed correctly
            ),

          ],
        ),
      ),
    );
  }
}
