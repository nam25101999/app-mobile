import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {

    // Khởi tạo responsive
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.primary,
      body: Stack(
        children: [

          // Đường bay nét đứt
          Positioned(
            top: Responsive.rh(165),
            left: Responsive.rw(0),
            child: SvgPicture.asset(
              'assets/bars/dashed_line.svg',
              width: Responsive.rw(209),
            ),
          ),

          // Đám mây góc trái
          Positioned(
            top: Responsive.rh(102),
            left: Responsive.rw(-10),
            child: SvgPicture.asset(
              'assets/bars/Vector 2.svg',
              width: Responsive.rw(94.57),
            ),
          ),

          // Đám mây góc phải (trên)
          Positioned(
            top: Responsive.rh(42),
            right: Responsive.rw(18.74),
            child: SvgPicture.asset(
              'assets/bars/cloud1.svg',
              width: Responsive.rw(91.26),
            ),
          ),

          // Đám mây góc phải (dưới mây trên một chút)
          Positioned(
            top: Responsive.rh(149),
            right: Responsive.rw(73),
            child: SvgPicture.asset(
              'assets/bars/cloud.svg',
              width: Responsive.rw(75),
            ),
          ),

          // Máy bay
          Positioned(
            top: Responsive.rh(104),
            right: Responsive.rw(103),
            child: SvgPicture.asset(
              'assets/bars/plane.svg',
              width: Responsive.rw(71.92),
            ),
          ),

          // Chiếc lá lớn bên phải
          Positioned(
            top: Responsive.rh(549.68),
            left: Responsive.rw(238.23),
            child: SvgPicture.asset(
              'assets/bars/Vector.svg',
              width: Responsive.rw(140),
            ),
          ),

          // Đồi nền lượn sóng (nằm dưới cùng của layer phần dưới)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/bars/Vector 4.svg',
              fit: BoxFit.fitWidth,
            ),
          ),

          // Cụm lá bên trái (Lá 1)
          Positioned(
            bottom: Responsive.rh(8.3),
            left: Responsive.rw(5.92),
            child: SvgPicture.asset(
              'assets/bars/Group.svg',
              width: Responsive.rw(54),
            ),
          ),

          // Cụm lá bên trái (Lá 2 - cao hơn)
          Positioned(
            top: Responsive.rh(626.63),
            left: Responsive.rw(45),
            child: SvgPicture.asset(
              'assets/bars/Group 1.svg',
              width: Responsive.rw(52),
            ),
          ),

          // Cái nón màu vàng
          Positioned(
            top: Responsive.rh(674.01),
            left: Responsive.rw(175),
            child: SvgPicture.asset(
              'assets/bars/Group-1.svg',
              width: Responsive.rw(96),
            ),
          ),

          // ==========================================
          // LOGO (Nằm giữa)
          // ==========================================
          Center(
            child: SvgPicture.asset(
              'assets/bars/Logo.svg',
              width: Responsive.rw(205),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}