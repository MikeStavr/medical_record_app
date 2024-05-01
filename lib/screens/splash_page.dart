import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_services_sharp,
              size: 100,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Colors.cyan,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
