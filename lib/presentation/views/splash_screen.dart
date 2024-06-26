import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate a splash screen with a delay before navigating
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/login'); // Navigate to LoginScreen after 2 seconds
    });

    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 25, 41),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Welcome to My App',style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}