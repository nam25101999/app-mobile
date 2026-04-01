import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';

import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'sign_up_screen.dart';
import 'package:demo/core/widgets/header.dart';
import 'package:demo/core/services/websocket_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controllers - Đã set mặc định admin và 123456
  final TextEditingController _emailController = TextEditingController(text: "admin");
  final TextEditingController _passwordController = TextEditingController(text: "123456");

  // Trạng thái loading
  bool _isLoading = false;

  late TapGestureRecognizer _signUpRecognizer;

  @override
  void initState() {
    super.initState();
    // Khởi tạo bộ nhận diện cử chỉ cho chữ "Sign Up"
    _signUpRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpScreen(),
          ),
        );
      };
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signUpRecognizer.dispose();
    super.dispose();
  }

  // Hàm xử lý Đăng nhập KHÔNG dùng Backend
  Future<void> _handleLogin() async {
    final emailOrUsername = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (emailOrUsername.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Giả lập độ trễ mạng (1 giây) để UX trông tự nhiên hơn
      await Future.delayed(const Duration(seconds: 1));

      // Kiểm tra cứng (Hardcode) tài khoản và mật khẩu
      if (emailOrUsername == 'admin' && password == '123456') {

        // Tạo token giả để duy trì logic kết nối WebSocket nếu cần
        const String dummyToken = "dummy_offline_token_123456";

        // 1. Kết nối WebSocket với Token giả
        WebSocketService.connect(dummyToken);

        // 2. Chuyển hướng sang màn hình chính
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/explore');
        }
      } else {
        // Sai thông tin đăng nhập
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Sai tài khoản hoặc mật khẩu!")),
          );
        }
      }
    } catch (e) {
      print("Lỗi khi xử lý đăng nhập: $e");
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
      backgroundColor: ColorsApp.primary, // Đổi nền gốc của màn hình thành màu xanh
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // Đảm bảo chiều cao tối thiểu bằng màn hình
              ),
              child: Stack(
                children: [
                  // HEADER SVGs
                  const Header(),

                  // ==========================================
                  // 2. PHẦN NỀN TRẮNG (Rectangle 5 - Đè lên SVGs ở trên)
                  // ==========================================
                  Positioned(
                    top: Responsive.rh(140), // Điểm bắt đầu của đường cong
                    left: 0,
                    right: 0,
                    bottom: 0, // Kéo dãn đến cuối màn hình
                    child: SvgPicture.asset(
                      'assets/login/Rectangle5.svg',
                      fit: BoxFit.cover, // Đảm bảo fill kín chiều ngang và dọc của không gian còn lại
                      alignment: Alignment.topCenter, // Giữ nguyên đường cong ở phía trên cùng
                    ),
                  ),

                  // ==========================================
                  // 3. NỘI DUNG CHÍNH (Form Đăng nhập)
                  // ==========================================
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: Responsive.rh(180)), // Đẩy form xuống dưới header
                    padding: EdgeInsets.symmetric(horizontal: Responsive.rw(32)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tiêu đề Sign In
                        Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: Responsive.rw(32),
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.textDark,
                          ),
                        ),
                        SizedBox(height: Responsive.rh(16)),

                        // Lời chào mừng
                        Text(
                          "Welcome back, Yoo Jin",
                          style: TextStyle(
                            fontSize: Responsive.rw(20),
                            fontWeight: FontWeight.w500,
                            color: ColorsApp.primary,
                          ),
                        ),
                        SizedBox(height: Responsive.rh(40)),

                        // Form nhập liệu
                        _buildTextField(
                          label: "Email / Username",
                          hint: "Type your account",
                          controller: _emailController,
                        ),

                        _buildTextField(
                          label: "Password",
                          hint: "Type password",
                          isPassword: true,
                          controller: _passwordController,
                        ),

                        // Quên mật khẩu
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgot_password');
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontSize: Responsive.rw(12),
                              color: ColorsApp.gray999,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        // Nút Sign In
                        SizedBox(
                          width: double.infinity,
                          height: Responsive.rh(50),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
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
                              "SIGN IN",
                              style: TextStyle(
                                fontSize: Responsive.rw(14),
                                fontWeight: FontWeight.bold,
                                color: ColorsApp.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.rh(32)),

                        // Đăng nhập bằng mạng xã hội
                        Center(
                          child: Text(
                            "or sign in with",
                            style: TextStyle(
                              fontSize: Responsive.rw(12),
                              color: ColorsApp.gray777,
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.rh(16)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Facebook
                            _buildSocialButton(
                              color: const Color(0xFF3B5998),
                              icon: Icons.facebook,
                              iconColor: Colors.white,
                            ),
                            SizedBox(width: Responsive.rw(16)),
                            // KakaoTalk
                            _buildSocialButton(
                              color: const Color(0xFFFEE500),
                              icon: Icons.chat_bubble,
                              iconColor: Colors.black,
                              text: "TALK",
                            ),
                            SizedBox(width: Responsive.rw(16)),
                            // Line
                            _buildSocialButton(
                              color: const Color(0xFF00C300),
                              icon: Icons.chat,
                              iconColor: Colors.white,
                              text: "LINE",
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.rh(40)),

                        // Chuyển sang đăng ký
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                fontSize: Responsive.rw(14),
                                color: ColorsApp.gray999,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: const TextStyle(
                                    color: ColorsApp.primary,
                                  ),
                                  recognizer: _signUpRecognizer, // Gắn sự kiện click
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.rh(40)), // Khoảng trống dưới cùng
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

  // Widget hỗ trợ vẽ ô nhập văn bản theo style thiết kế
  Widget _buildTextField({
    required String label,
    required String hint,
    bool isPassword = false,
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

  // Widget hỗ trợ vẽ nút Social Media
  Widget _buildSocialButton({
    required Color color,
    required IconData icon,
    required Color iconColor,
    String? text,
  }) {
    return Container(
      width: Responsive.rw(48),
      height: Responsive.rw(48),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Responsive.rw(8)),
      ),
      child: Center(
        child: text != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: Responsive.rw(20)),
            Text(
              text,
              style: TextStyle(
                color: iconColor,
                fontSize: Responsive.rw(8),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
            : Icon(icon, color: iconColor, size: Responsive.rw(28)),
      ),
    );
  }
}