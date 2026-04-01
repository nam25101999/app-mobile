import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'sign_in_screen.dart';
import 'package:demo/core/widgets/header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Controller cho ô nhập email
  final TextEditingController _emailController = TextEditingController(text: "yoojin@gmail.com");

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
    _emailController.dispose();
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
                  // 3. NỘI DUNG CHÍNH (Form Quên Mật Khẩu)
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
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: Responsive.rw(32),
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.textDark,
                          ),
                        ),
                        SizedBox(height: Responsive.rh(16)),

                        // Mô tả
                        Text(
                          "Input your email, we will send you an\ninstruction to reset your password.",
                          style: TextStyle(
                            fontSize: Responsive.rw(14),
                            color: ColorsApp.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: Responsive.rh(40)),

                        // Ô nhập Email
                        _buildTextField(
                          label: "Email",
                          hint: "Type email",
                          controller: _emailController,
                        ),
                        SizedBox(height: Responsive.rh(16)),

                        // Nút Gửi (SEND)
                        SizedBox(
                          width: double.infinity,
                          height: Responsive.rh(50),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/check_email');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsApp.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Responsive.rw(8)),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              "SEND",
                              style: TextStyle(
                                fontSize: Responsive.rw(14),
                                fontWeight: FontWeight.bold,
                                color: ColorsApp.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: Responsive.rh(40)),

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

  // Widget hỗ trợ vẽ ô nhập văn bản
  Widget _buildTextField({
    required String label,
    required String hint,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.rh(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.rw(14),
              color: ColorsApp.textDark,
            ),
          ),
          SizedBox(height: Responsive.rh(4)),
          TextField(
            controller: controller,
            style: TextStyle(
              fontSize: Responsive.rw(14),
              color: ColorsApp.textSecondary,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: ColorsApp.grayAFAFAF,
                fontSize: Responsive.rw(14),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(8)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: ColorsApp.grayDBDBDB),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: ColorsApp.primary, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}