import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:demo/core/constants/responsive.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Responsive.rh(200), // chiều cao header
      child: Stack(
        children: [
          // Vector 1 - đường bay
          Positioned(
            top: Responsive.rh(96),
            left: Responsive.rw(92),
            child: SvgPicture.asset(
              'assets/login/Vector 1.svg',
              width: Responsive.rw(209),
              height: Responsive.rh(96),
            ),
          ),

          // Vector 6 - đám mây
          Positioned(
            top: Responsive.rh(99),
            left: Responsive.rw(215),
            child: SvgPicture.asset(
              'assets/login/Vector 6.svg',
              width: Responsive.rw(57),
              height: Responsive.rh(25),
            ),
          ),

          // Máy bay
          Positioned(
            top: Responsive.rh(48.78),
            left: Responsive.rw(289),
            child: Transform.rotate(
              angle: 25.41 * math.pi / 180,
              child: SvgPicture.asset(
                'assets/login/Vector.svg',
                width: Responsive.rw(73.7),
                height: Responsive.rh(44.22),
              ),
            ),
          ),

          // Logo
          Positioned(
            top: Responsive.rh(59),
            left: Responsive.rw(32),
            child: SvgPicture.asset(
              'assets/login/Group 3.svg',
              width: Responsive.rw(56),
              height: Responsive.rh(56),
            ),
          ),
        ],
      ),
    );
  }
}