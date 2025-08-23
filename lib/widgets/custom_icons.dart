import 'package:flutter/material.dart';
import 'package:notes/constants.dart';

class CustomIcons extends StatelessWidget {
  final String iconType;
  //final VoidCallback onTap;
  final double size;

  const CustomIcons({super.key, required this.iconType,  required this.size});

  @override
  Widget build(BuildContext context) {
    IconData iconData;

    switch (iconType) {
      case 'google':
        iconData = Icons.g_mobiledata_rounded;
        break;
      case 'apple':
        iconData = Icons.apple;
        break;
      default:
        iconData = Icons.help; 
        break;
    }

    return GestureDetector(
      //onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          iconData,
          size: size,
          color: Colors.white,
        ),
      ),
    );
  }
}
