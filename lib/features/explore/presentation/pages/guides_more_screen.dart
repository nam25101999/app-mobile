import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class GuidesMoreScreen extends StatefulWidget {
  const GuidesMoreScreen({super.key});

  @override
  State<GuidesMoreScreen> createState() => _GuidesMoreScreenState();
}

class _GuidesMoreScreenState extends State<GuidesMoreScreen> {
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
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
                      image: NetworkImage('https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?q=80&w=800&fit=crop'), // Ảnh placeholder phù hợp
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
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
                // Nội dung Header (Nút Back, Tiêu đề)
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
                          "Book your own private local\nGuide and explore the city",
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
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Hi, where do you want to explore?",
                        hintStyle: TextStyle(
                          color: ColorsApp.grayAFAFAF,
                          fontSize: Responsive.rw(14),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorsApp.grayAFAFAF,
                          size: Responsive.rw(20),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(15)),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: Responsive.rh(50)), // Bù khoảng trống cho search bar

            // ==========================================
            // GRID DANH SÁCH GUIDES
            // ==========================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
              child: Wrap(
                spacing: Responsive.rw(15),
                runSpacing: Responsive.rh(20),
                children: [
                  _buildBestGuideCard(
                    image: 'https://randomuser.me/api/portraits/men/32.jpg',
                    name: "Tuan Tran",
                    location: "Danang, Vietnam",
                    reviews: "127",
                  ),
                  _buildBestGuideCard(
                    image: 'https://randomuser.me/api/portraits/women/44.jpg',
                    name: "Emmy",
                    location: "Hanoi, Vietnam",
                    reviews: "89",
                  ),
                  _buildBestGuideCard(
                    image: 'https://randomuser.me/api/portraits/women/68.jpg',
                    name: "Linh Hana",
                    location: "Danang, Vietnam",
                    reviews: "127",
                  ),
                  _buildBestGuideCard(
                    image: 'https://randomuser.me/api/portraits/men/46.jpg',
                    name: "Khai Ho",
                    location: "Ho Chi Minh, Vietnam",
                    reviews: "127",
                  ),
                  _buildBestGuideCard(
                    image: 'https://randomuser.me/api/portraits/men/50.jpg', // Lặp lại dữ liệu test
                    name: "Tuan Tran",
                    location: "Danang, Vietnam",
                    reviews: "127",
                  ),
                  _buildBestGuideCard(
                    image: 'https://randomuser.me/api/portraits/women/50.jpg',
                    name: "Emmy",
                    location: "Hanoi, Vietnam",
                    reviews: "89",
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(30)),

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

  // Card Guide (Lưới 2 cột)
  Widget _buildBestGuideCard({
    required String image,
    required String name,
    required String location,
    required String reviews,
  }) {
    final width = (Responsive.screenWidth - Responsive.rw(40) - Responsive.rw(15)) / 2;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Responsive.rw(12)),
                child: Image.network(image, height: width, width: width, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  height: Responsive.rh(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Responsive.rw(12)),
                      bottomRight: Radius.circular(Responsive.rw(12)),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: Responsive.rh(10), left: Responsive.rw(10),
                child: _buildStars(reviews),
              ),
            ],
          ),
          SizedBox(height: Responsive.rh(8)),
          Text(
            name,
            style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.bold, color: ColorsApp.textDark),
          ),
          SizedBox(height: Responsive.rh(4)),
          Row(
            children: [
              Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(12)),
              SizedBox(width: Responsive.rw(4)),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStars(String reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(5, (index) => Icon(Icons.star, color: ColorsApp.warning, size: Responsive.rw(12))),
        ),
        SizedBox(height: Responsive.rh(4)),
        Text(
          "$reviews Reviews",
          style: TextStyle(color: Colors.white, fontSize: Responsive.rw(10), fontWeight: FontWeight.w500),
        ),
      ],
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