// splash_screen.dart
import 'package:flutter/material.dart';
import 'pcb_screen.dart'; // Import PCBScreen for navigation after splash

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _progressValue += 0.02; // Increase progress by 2%
      });

      // Keep updating the progress until it reaches 100%
      if (_progressValue < 1.0) {
        _startLoading(); // Continue the loading process
      } else {
        // Navigate to the PCBScreen once loading is complete
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PCBScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 18, 22, 24), // Set the splash background color here
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 100, // Adjust width to control logo size
              height: 100, // Adjust height to control logo size
              child: Image.asset(
                'assets/logo/logo.png', // Ensure the logo is correctly placed in assets/images
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 30), // Add space between logo and progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: LinearProgressIndicator(
              value: _progressValue,
              backgroundColor: const Color.fromARGB(255, 58, 60, 61),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFE2F14F)), // Use brand color
              minHeight: 10,
            ),
          ),
          const SizedBox(
              height: 10), // Space between progress bar and percentage
          Text(
            '${(_progressValue * 100).toInt()}%', // Show percentage
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
