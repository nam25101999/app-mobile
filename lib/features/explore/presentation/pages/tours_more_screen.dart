import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class ToursMoreScreen extends StatefulWidget {
  const ToursMoreScreen({super.key});

  @override
  State<ToursMoreScreen> createState() => _ToursMoreScreenState();
}

class _ToursMoreScreenState extends State<ToursMoreScreen> {
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ==========================================
            // HEADER & SEARCH BAR
            // ==========================================
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Hình nền Header
                Container(
                  width: double.infinity,
                  height: Responsive.rh(220),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=800&fit=crop'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Lớp phủ Gradient tối màu
                Container(
                  width: double.infinity,
                  height: Responsive.rh(220),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
                // Nội dung Header
                SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: Responsive.rw(22)),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(10)),
                        child: Text(
                          "Plenty of amazing of tours are\nwaiting for you",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.rw(24),
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Thanh Tìm kiếm
                Positioned(
                  bottom: -Responsive.rh(25),
                  left: Responsive.rw(20),
                  right: Responsive.rw(20),
                  child: Container(
                    height: Responsive.rh(50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Responsive.rw(8)),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Hi, where do you want to explore?",
                        hintStyle: TextStyle(color: ColorsApp.grayAFAFAF, fontSize: Responsive.rw(14)),
                        prefixIcon: Icon(Icons.search, color: ColorsApp.grayAFAFAF, size: Responsive.rw(20)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(15)),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: Responsive.rh(50)), // Bù khoảng trống

            // ==========================================
            // LIST DANH SÁCH TOURS
            // ==========================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
              child: Column(
                children: [
                  _buildFeaturedTourCard(
                    image: 'https://images.unsplash.com/photo-1576487248805-4c6e5ce6165e?q=80&w=600&fit=crop',
                    title: "Da Nang - Ba Na - Hoi An",
                    date: "Jan 30, 2020",
                    days: "3 days",
                    price: "\$400.00",
                    likes: "1247",
                  ),
                  _buildFeaturedTourCard(
                    image: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?q=80&w=600&fit=crop',
                    title: "Melbourne - Sydney",
                    date: "Jan 30, 2020",
                    days: "3 days",
                    price: "\$600.00",
                    likes: "1247",
                    isFavorited: true,
                  ),
                  _buildFeaturedTourCard(
                    image: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=600&fit=crop',
                    title: "Hanoi - Ha Long Bay",
                    date: "Jan 30, 2020",
                    days: "3 days",
                    price: "\$300.00",
                    likes: "1247",
                  ),
                  _buildFeaturedTourCard(
                    image: 'https://images.unsplash.com/photo-1576487248805-4c6e5ce6165e?q=80&w=600&fit=crop',
                    title: "Da Nang - Ba Na - Hoi An",
                    date: "Jan 30, 2020",
                    days: "3 days",
                    price: "\$400.00",
                    likes: "1247",
                  ),
                  _buildFeaturedTourCard(
                    image: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?q=80&w=600&fit=crop',
                    title: "Melbourne - Sydney",
                    date: "Jan 30, 2020",
                    days: "3 days",
                    price: "\$600.00",
                    likes: "1247",
                    isFavorited: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(10)),

            // ==========================================
            // PAGINATION DOTS
            // ==========================================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(isActive: true),
                SizedBox(width: Responsive.rw(6)),
                _buildDot(isActive: false),
                SizedBox(width: Responsive.rw(6)),
                _buildDot(isActive: false),
              ],
            ),
            SizedBox(height: Responsive.rh(40)),
          ],
        ),
      ),
    );
  }

  // Card hiển thị Tour (giống màn Explore)
  Widget _buildFeaturedTourCard({
    required String image,
    required String title,
    required String date,
    required String days,
    required String price,
    required String likes,
    bool isFavorited = false,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: Responsive.rh(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.rw(12)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(Responsive.rw(12))),
                child: Image.network(image, height: Responsive.rh(140), width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  height: Responsive.rh(40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter, end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(top: Responsive.rh(10), right: Responsive.rw(10), child: Icon(Icons.bookmark_border, color: Colors.white, size: Responsive.rw(20))),
              Positioned(
                bottom: Responsive.rh(10), left: Responsive.rw(10),
                child: Row(
                  children: [
                    ...List.generate(5, (index) => Icon(Icons.star, color: ColorsApp.warning, size: Responsive.rw(12))),
                    SizedBox(width: Responsive.rw(4)),
                    Text("$likes likes", style: TextStyle(color: Colors.white, fontSize: Responsive.rw(10), fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Responsive.rw(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: Responsive.rw(16), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
                    Icon(isFavorited ? Icons.favorite : Icons.favorite_border, color: ColorsApp.primary, size: Responsive.rw(20)),
                  ],
                ),
                SizedBox(height: Responsive.rh(8)),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: ColorsApp.gray999, size: Responsive.rw(12)),
                    SizedBox(width: Responsive.rw(4)),
                    Text(date, style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12))),
                  ],
                ),
                SizedBox(height: Responsive.rh(4)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: ColorsApp.gray999, size: Responsive.rw(12)),
                        SizedBox(width: Responsive.rw(4)),
                        Text(days, style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12))),
                      ],
                    ),
                    Text(price, style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(16), fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: Responsive.rw(8),
      height: Responsive.rw(8),
      decoration: BoxDecoration(
        color: isActive ? ColorsApp.grayDBDBDB : ColorsApp.grayE8E8E8,
        shape: BoxShape.circle,
      ),
    );
  }
}