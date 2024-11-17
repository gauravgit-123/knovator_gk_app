import 'package:flutter/material.dart';
import 'package:knovator_gk_app/utils/routing/routes_name.dart';

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
    await Future.delayed(Duration(seconds: 3)); // Show the splash screen for 3 seconds
    Navigator.pushReplacementNamed(context, RouteName.postListScreen);
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
              'assets/images/knovator_logo.jpg',
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
