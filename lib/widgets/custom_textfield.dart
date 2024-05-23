import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  const CustomTextField(
      {super.key,
      required this.label,
      this.controller,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(label),
        border: const OutlineInputBorder(),
      ),
      controller: controller,
      obscureText: isPassword,
    );
  }
}
