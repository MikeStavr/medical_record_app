import 'package:flutter/material.dart';

class CustomFabHome extends StatelessWidget {
  const CustomFabHome({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/');
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Colors.cyan[100],
      child: const Icon(Icons.home),
    );
  }
}
