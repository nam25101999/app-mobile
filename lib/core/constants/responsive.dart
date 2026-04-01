import 'package:flutter/material.dart';

class Responsive {
  static late double screenWidth;
  static late double screenHeight;

  // Kích thước design Figma
  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  // Responsive width
  static double rw(double width) {
    return screenWidth * (width / figmaWidth);
  }

  // Responsive height
  static double rh(double height) {
    return screenHeight * (height / figmaHeight);
  }
}