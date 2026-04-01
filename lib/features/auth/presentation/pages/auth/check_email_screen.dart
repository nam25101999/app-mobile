import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'sign_in_screen.dart';
import 'package:demo/core/widgets/header.dart';

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({super.key});

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  late TapGestureRecognizer _signInRecognizer;

  @override
  void initState() {
    super.initState();
    // Khởi tạo bộ nhận diện cử chỉ cho chữ "Sign In"
    _signInRecognizer = TapGestureRecognizer()
      ..onTap = () {
        // Trở về màn hình đăng nhập
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
      };
  }

  @override
  void dispose() {
    _signInRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.primary, // Nền xanh của Header
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // Kéo dãn tối thiểu bằng chiều cao màn hình
              ),
              child: Stack(
                children: [
                  // HEADER SVGs
                  const Header(),

                  // ==========================================
                  // 2. PHẦN NỀN TRẮNG (Rectangle 5 - đè lên SVGs)
                  // ==========================================
                  Positioned(
                    top: Responsive.rh(140), // Vị trí viền cong bắt đầu
                    left: 0,
                    right: 0,
                    bottom: 0, // Kéo dãn kịch kim xuống tận cùng màn hình
                    child: SvgPicture.asset(
                      'assets/login/Rectangle5.svg',
                      fit: BoxFit.cover, // Căng trọn không gian trống bên dưới
                      alignment: Alignment.topCenter,
                    ),
                  ),

                  // ==========================================
                  // 3. NỘI DUNG CHÍNH (Check Email)
                  // ==========================================
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: Responsive.rh(180)), // Đẩy nội dung qua viền cong
                    padding: EdgeInsets.symmetric(horizontal: Responsive.rw(32)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tiêu đề
                        Text(
                          "Check Email",
                          style: TextStyle(
                            fontSize: Responsive.rw(32),
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.textDark,
                          ),
                        ),
                        SizedBox(height: Responsive.rh(16)),

                        // Mô tả
                        Text(
                          "Please check your email for the instructions on\nhow to reset your password.",
                          style: TextStyle(
                            fontSize: Responsive.rw(14),
                            color: ColorsApp.textSecondary,
                            height: 1.5,
                          ),
                        ),

                        // Khoảng cách đến hình bức thư
                        SizedBox(height: Responsive.rh(60)),

                        // Hình ảnh bức thư (Envelope)
                        Center(
                          child: SvgPicture.asset(
                            'assets/login/envelope.svg',
                            width: Responsive.rw(142),
                            height: Responsive.rh(156),
                          ),
                        ),

                        // Khoảng cách đẩy nút "Back to Sign In" xuống dưới
                        SizedBox(height: Responsive.rh(80)),

                        // Nút trở lại Sign In
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Back to ",
                              style: TextStyle(
                                fontSize: Responsive.rw(14),
                                color: ColorsApp.gray999,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign In",
                                  style: const TextStyle(
                                    color: ColorsApp.primary,
                                  ),
                                  recognizer: _signInRecognizer, // Trở về Sign In khi click
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.rh(40)), // Đệm đáy an toàn
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}