import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import '../auth/sign_in_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controller quản lý PageView
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Hàm chuyển sang màn Home/Login
  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
    print("Go to Login");
  }

  @override
  Widget build(BuildContext context) {
    // Khởi tạo responsive (Figma 375x812)
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // ==========================================
            // 1. PAGE VIEW (Swipe content)
            // ==========================================
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              physics: const BouncingScrollPhysics(),
              children: [
                _buildPage01(),
                _buildPage02(),
                _buildPage03(),
              ],
            ),

            // ==========================================
            // 2. INDICATOR (Chỉ báo trang)
            // ==========================================
            Positioned(
              top: Responsive.rh(680),
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                      (index) => _buildDot(index: index),
                ),
              ),
            ),

            // ==========================================
            // 3. NÚT SKIP (Hiển thị ở Page 1 & 2)
            // ==========================================
            if (_currentPage != 2)
              Positioned(
                bottom: Responsive.rh(30),
                right: Responsive.rw(20),
                child: TextButton(
                  onPressed: _goToLogin, // Bấm Skip qua luôn Login
                  child: Text(
                    "SKIP",
                    style: TextStyle(
                      fontSize: Responsive.rw(14),
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.gray777,
                    ),
                  ),
                ),
              ),

            // ==========================================
            // 4. NÚT GET STARTED (Chỉ hiển thị ở Page 3)
            // ==========================================
            if (_currentPage == 2)
              Positioned(
                bottom: Responsive.rh(60),
                left: Responsive.rw(40),
                right: Responsive.rw(40),
                child: ElevatedButton(
                  onPressed: _goToLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primary,
                    padding: EdgeInsets.symmetric(
                      vertical: Responsive.rh(16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Responsive.rw(8)),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                      fontSize: Responsive.rw(14),
                      fontWeight: FontWeight.bold,
                      color: ColorsApp.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET INDICATOR DOT (Có hiệu ứng Animation)
  // ==========================================
  Widget _buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: Responsive.rw(6)),
      width: _currentPage == index ? Responsive.rw(24) : Responsive.rw(12),
      height: Responsive.rh(4),
      decoration: BoxDecoration(
        color: _currentPage == index ? ColorsApp.primary : ColorsApp.grayDBDBDB,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // ==========================================
  // GIAO DIỆN PAGE 1
  // ==========================================
  Widget _buildPage01() {
    return Stack(
      children: [
        // Khối nền xanh ngọc uốn lượn (Vector 7)
        Positioned(
          top: Responsive.rh(29.88),
          left: Responsive.rw(28.45),
          child: SvgPicture.asset(
            'assets/onboarding/Vector 7.svg',
            width: Responsive.rw(347.55),
            height: Responsive.rh(466.16),
          ),
        ),

        // Đám mây nhỏ bên trái (Vector 5)
        Positioned(
          top: Responsive.rh(75),
          left: Responsive.rw(49),
          child: SvgPicture.asset(
            'assets/onboarding/Vector 5.svg',
            width: Responsive.rw(91.26),
            height: Responsive.rh(39.57),
          ),
        ),

        // Cô gái mặc váy vàng (Group 108)
        Positioned(
          top: Responsive.rh(189),
          left: Responsive.rw(66.48),
          child: SvgPicture.asset(
            'assets/onboarding/Group 108.svg',
            width: Responsive.rw(125.16),
            height: Responsive.rh(278.02),
          ),
        ),

        // Chàng trai đeo balo (Group 107)
        Positioned(
          top: Responsive.rh(186.99),
          left: Responsive.rw(173.86),
          child: SvgPicture.asset(
            'assets/onboarding/Group 107.svg',
            width: Responsive.rw(154.16),
            height: Responsive.rh(282.3),
          ),
        ),

        // Nhóm Text: Tiêu đề và Mô tả
        Positioned(
          top: Responsive.rh(540),
          left: Responsive.rw(40),
          right: Responsive.rw(40),
          child: Column(
            children: [
              Text(
                "Find a local guide easily",
                style: TextStyle(
                  fontSize: Responsive.rw(24),
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.rh(16)),
              Text(
                "With Fellow4U, you can find a local\n"
                    "guide for you trip easily and explore\n"
                    "as the way you want.",
                style: TextStyle(
                  fontSize: Responsive.rw(14),
                  color: ColorsApp.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // GIAO DIỆN PAGE 2
  // ==========================================
  Widget _buildPage02() {
    return Stack(
      children: [
        Positioned(
          top: Responsive.rh(92),
          left: 0,
          child: SvgPicture.asset(
            'assets/onboarding/Vector 8.svg',
            width: Responsive.rw(376),
            height: Responsive.rh(376.03),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: Responsive.rh(67.4),
          left: Responsive.rw(41),
          child: SvgPicture.asset(
            'assets/onboarding/Group 98.svg',
            width: Responsive.rw(152.18),
            height: Responsive.rh(128.8),
          ),
        ),
        Positioned(
          top: Responsive.rh(59),
          left: Responsive.rw(176.52),
          child: SvgPicture.asset(
            'assets/onboarding/Group 99.svg',
            width: Responsive.rw(153.61),
            height: Responsive.rh(136.68),
          ),
        ),
        Positioned(
          top: Responsive.rh(179.41),
          left: Responsive.rw(138.97),
          child: SvgPicture.asset(
            'assets/onboarding/Group 101.svg',
            width: Responsive.rw(97.66),
            height: Responsive.rh(291.52),
          ),
        ),
        Positioned(
          top: Responsive.rh(33),
          left: Responsive.rw(222),
          child: SvgPicture.asset(
            'assets/onboarding/Vector 5.svg',
            width: Responsive.rw(79),
            height: Responsive.rh(35),
          ),
        ),
        Positioned(
          top: Responsive.rh(540),
          left: Responsive.rw(40),
          right: Responsive.rw(40),
          child: Column(
            children: [
              Text(
                "Many tours around the world",
                style: TextStyle(
                  fontSize: Responsive.rw(24),
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.rh(16)),
              Text(
                "Lorem Ipsum is simply dummy text of\nthe printing and typesetting industry.",
                style: TextStyle(
                  fontSize: Responsive.rw(14),
                  color: ColorsApp.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // GIAO DIỆN PAGE 3
  // ==========================================
  Widget _buildPage03() {
    return Stack(
      children: [
        Positioned(
          top: Responsive.rh(62.04),
          left: Responsive.rw(15.5),
          right: Responsive.rw(15.5),
          child: SvgPicture.asset(
            'assets/onboarding/Group 177.svg',
            width: Responsive.rw(344),
            height: Responsive.rh(423.73),
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: Responsive.rh(540),
          left: Responsive.rw(40),
          right: Responsive.rw(40),
          child: Column(
            children: [
              Text(
                "Create a trip and get offers",
                style: TextStyle(
                  fontSize: Responsive.rw(24),
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.rh(16)),
              Text(
                "Fellow4U helps you save time and get\noffers from hundred local guides that\nsuit your trip.",
                style: TextStyle(
                  fontSize: Responsive.rw(14),
                  color: ColorsApp.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}