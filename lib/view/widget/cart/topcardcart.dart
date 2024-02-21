import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class TopCardCart extends StatelessWidget {
  final String message;

  const TopCardCart({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 3, horizontal: 20), // Symmetric padding for better spacing
      margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 1), // Added vertical margin for spacing from other elements
      decoration: BoxDecoration(
        color: AppColor.lightPrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // Added shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold, // Added bold for emphasis
          fontSize: 16, // Increased font size for better readability
        ),
      ),
    );
  }
}
