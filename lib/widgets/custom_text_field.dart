import 'package:flutter/material.dart';
import 'package:notes/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.suffixIcon,
  });
  final String label;
  final String hint;
  final Icon suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 119, 119, 119),
          fontFamily: 'Roboto',
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
