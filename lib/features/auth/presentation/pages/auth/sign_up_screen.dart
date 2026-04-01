import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';

import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'sign_in_screen.dart';
import 'package:demo/core/widgets/header.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Biến trạng thái cho Radio Button
  bool isTraveler = true;
  bool _isLoading = false;

  // Controllers để lấy dữ liệu từ form
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late TapGestureRecognizer _signInRecognizer;

  @override
  void initState() {
    super.initState();
    // Khởi tạo bộ nhận diện cử chỉ cho chữ "Sign In"
    _signInRecognizer = TapGestureRecognizer()
      ..onTap = () {
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
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _signInRecognizer.dispose(); // Giải phóng bộ nhớ
    super.dispose();
  }

  // Hàm xử lý logic Đăng ký KHÔNG dùng Backend
  Future<void> _handleSignUp() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // 1. Kiểm tra rỗng
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng điền đầy đủ thông tin!")),
      );
      return;
    }

    // 2. Kiểm tra mật khẩu khớp nhau
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mật khẩu xác nhận không khớp!")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Giả lập độ trễ mạng (1.5 giây) để UX trông tự nhiên hơn
      await Future.delayed(const Duration(milliseconds: 1500));

      // Không gọi API nữa, tự động coi như đăng ký thành công nếu đã qua bước validate
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng ký thành công! Vui lòng đăng nhập.")),
        );
        // Chuyển về màn hình đăng nhập
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      }
    } catch (e) {
      print("Lỗi khi xử lý Đăng ký: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đã xảy ra lỗi không xác định")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                  // 3. NỘI DUNG CHÍNH (Form Đăng ký)
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
                          "Sign Up",
                          style: TextStyle(
                            fontSize: Responsive.rw(32),
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.textDark,
                          ),
                        ),
                        SizedBox(height: Responsive.rh(24)),

                        // Lựa chọn vai trò (Radio Buttons)
                        Row(
                          children: [
                            _buildCustomRadio("Traveler", isTraveler, () {
                              setState(() => isTraveler = true);
                            }),
                            SizedBox(width: Responsive.rw(32)),
                            _buildCustomRadio("Guide", !isTraveler, () {
                              setState(() => isTraveler = false);
                            }),
                          ],
                        ),
                        SizedBox(height: Responsive.rh(32)),

                        // Form nhập liệu đã được cập nhật
                        _buildTextField(
                          label: "Username",
                          hint: "Type username",
                          controller: _usernameController,
                        ),

                        _buildTextField(
                          label: "Email",
                          hint: "Type email",
                          controller: _emailController,
                        ),

                        _buildTextField(
                          label: "Password",
                          hint: "Type password",
                          isPassword: true,
                          helperText: "Password has more than 6 letters",
                          controller: _passwordController,
                        ),

                        _buildTextField(
                          label: "Confirm Password",
                          hint: "Type confirm password",
                          isPassword: true,
                          controller: _confirmPasswordController,
                        ),
                        SizedBox(height: Responsive.rh(24)),

                        // Điều khoản
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "By Signing Up, you agree to our ",
                              style: TextStyle(
                                fontSize: Responsive.rw(12),
                                color: ColorsApp.gray999,
                              ),
                              children: const [
                                TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(color: ColorsApp.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.rh(16)),

                        // Nút Sign Up
                        SizedBox(
                          width: double.infinity,
                          height: Responsive.rh(50),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleSignUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsApp.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Responsive.rw(8)),
                              ),
                              elevation: 2,
                            ),
                            child: _isLoading
                                ? SizedBox(
                              width: Responsive.rw(24),
                              height: Responsive.rw(24),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: Responsive.rw(14),
                                fontWeight: FontWeight.bold,
                                color: ColorsApp.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.rh(24)),

                        // Trở về đăng nhập
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontSize: Responsive.rw(14),
                                color: ColorsApp.gray999,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign In",
                                  style: const TextStyle(
                                    color: ColorsApp.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: _signInRecognizer,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.rh(40)),
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
    bool isPassword = false,
    String? helperText,
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
            obscureText: isPassword,
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
              helperText: helperText,
              helperStyle: TextStyle(
                color: ColorsApp.gray999,
                fontSize: Responsive.rw(10),
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

  // Widget hỗ trợ vẽ Radio Button custom
  Widget _buildCustomRadio(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Responsive.rw(20),
            height: Responsive.rw(20),
            padding: EdgeInsets.all(Responsive.rw(3)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? ColorsApp.primary : ColorsApp.gray999,
                width: 2,
              ),
            ),
            child: isSelected
                ? Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsApp.primary,
              ),
            )
                : null,
          ),
          SizedBox(width: Responsive.rw(8)),
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.rw(16),
              fontWeight: FontWeight.w600,
              color: ColorsApp.textDark,
            ),
          ),
        ],
      ),
    );
  }
}