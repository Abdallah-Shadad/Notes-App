import 'package:flutter/material.dart';
import 'package:notes/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.btnName});
  final String btnName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 500,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          btnName,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
