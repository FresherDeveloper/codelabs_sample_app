import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.validatorTxt,
    this.obscureText = false,
    required this.controller,
  });

  final TextEditingController controller;
  final String labelText;
  final String validatorTxt;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText, //'Email',
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validatorTxt; //'Please enter your email';
        }
        return null;
      },
    );
  }
}
