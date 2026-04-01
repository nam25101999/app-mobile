import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'package:demo/core/widgets/custom_bottom_nav.dart';
import 'settings_screen.dart';
import 'my_photos_screen.dart';
import 'my_journeys_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // HEADER: COVER & AVATAR
            // ==========================================
            _buildHeader(context),
            SizedBox(height: Responsive.rh(60)), // Bù khoảng trống do Avatar đè xuống

            // ==========================================
            // USER INFO
            // ==========================================
            Center(
              child: Column(
                children: [
                  Text(
                    "Yoo Jin",
                    style: TextStyle(fontSize: Responsive.rw(24), fontWeight: FontWeight.bold, color: ColorsApp.textDark),
                  ),
                  SizedBox(height: Responsive.rh(4)),
                  Text(
                    "yoojin@gmail.com",
                    style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.gray999),
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(30)),

            // ==========================================
            // MY PHOTOS SECTION
            // ==========================================
            _buildSectionHeader("My Photos", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyPhotosScreen()));
            }),
            _buildPhotosPreview(),
            SizedBox(height: Responsive.rh(30)),

            // ==========================================
            // MY JOURNEYS SECTION
            // ==========================================
            _buildSectionHeader("My Journeys", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyJourneysScreen()));
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
              child: Column(
                children: [
                  _buildJourneyCard(
                    title: "A memory in Danang",
                    location: "Danang, Vietnam",
                    date: "Jan 20, 2020",
                    likes: "234",
                    image1: 'https://images.unsplash.com/photo-1555126634-323283e090b0?q=80&w=400&fit=crop', // Đồ ăn
                    image2: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=400&fit=crop', // Nhà thờ
                    image3: 'https://images.unsplash.com/photo-1540202404-b71114228965?q=80&w=400&fit=crop', // Hồ bơi
                  ),
                  SizedBox(height: Responsive.rh(20)),
                  _buildJourneyCard(
                    title: "Sapa in spring",
                    location: "Sapa, Vietnam",
                    date: "Jan 20, 2020",
                    likes: "234",
                    image1: 'https://images.unsplash.com/photo-1559925393-8be0ca47e58c?q=80&w=400&fit=crop', // Sapa
                    image2: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=400&fit=crop',
                    image3: 'https://images.unsplash.com/photo-1565670105658-9562470eb06b?q=80&w=400&fit=crop',
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(40)),
          ],
        ),
      ),

      // ==========================================
      // BOTTOM NAVIGATION
      // ==========================================
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Ảnh Cover
        Image.network(
          'https://images.unsplash.com/photo-1546874177-9e664107314e?q=80&w=800&fit=crop', // Cảnh hoàng hôn
          width: double.infinity,
          height: Responsive.rh(200),
          fit: BoxFit.cover,
        ),
        // Lớp phủ Gradient đen
        Container(
          width: double.infinity,
          height: Responsive.rh(200),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.4), Colors.transparent],
            ),
          ),
        ),
        // Nút Cài đặt & Camera Cover
        SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(), // Spacer
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                  child: Icon(Icons.settings_outlined, color: Colors.white, size: Responsive.rw(28)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: Responsive.rh(15), right: Responsive.rw(15),
          child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: Responsive.rw(24)),
        ),
        // Avatar (Nằm đè nửa trên nửa dưới)
        Positioned(
          bottom: -Responsive.rh(50),
          left: 0, right: 0,
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: Responsive.rw(4)),
                  ),
                  child: CircleAvatar(
                    radius: Responsive.rw(50),
                    backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
                  ),
                ),
                // Icon camera nhỏ cho avatar
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    padding: EdgeInsets.all(Responsive.rw(6)),
                    decoration: const BoxDecoration(color: ColorsApp.white, shape: BoxShape.circle),
                    child: Icon(Icons.camera_alt, color: ColorsApp.primary, size: Responsive.rw(16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(left: Responsive.rw(20), right: Responsive.rw(20), bottom: Responsive.rh(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: Responsive.rw(20), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
          GestureDetector(
            onTap: onTap,
            child: Icon(Icons.keyboard_double_arrow_right, color: ColorsApp.gray999, size: Responsive.rw(20)),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosPreview() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Image.network('https://images.unsplash.com/photo-1540202404-b71114228965?q=80&w=400&fit=crop', height: Responsive.rh(100), fit: BoxFit.cover)),
            SizedBox(width: Responsive.rw(2)),
            Expanded(child: Image.network('https://images.unsplash.com/photo-1565670105658-9562470eb06b?q=80&w=400&fit=crop', height: Responsive.rh(100), fit: BoxFit.cover)),
            SizedBox(width: Responsive.rw(2)),
            Expanded(child: Image.network('https://images.unsplash.com/photo-1476611317561-60117649dd94?q=80&w=400&fit=crop', height: Responsive.rh(100), fit: BoxFit.cover)),
          ],
        ),
        SizedBox(height: Responsive.rh(2)),
        Image.network('https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?q=80&w=800&fit=crop', height: Responsive.rh(120), width: double.infinity, fit: BoxFit.cover),
      ],
    );
  }

  Widget _buildJourneyCard({required String title, required String location, required String date, required String likes, required String image1, required String image2, required String image3}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.rw(12)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          // Collage Ảnh
          SizedBox(
            height: Responsive.rh(160),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(Responsive.rw(12))),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Image.network(image1, fit: BoxFit.cover, height: double.infinity)),
                  SizedBox(width: Responsive.rw(2)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(child: Image.network(image2, fit: BoxFit.cover, width: double.infinity)),
                        SizedBox(height: Responsive.rh(2)),
                        Expanded(child: Image.network(image3, fit: BoxFit.cover, width: double.infinity)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Info
          Padding(
            padding: EdgeInsets.all(Responsive.rw(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: Responsive.rw(16), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
                    Icon(Icons.more_horiz, color: ColorsApp.gray999),
                  ],
                ),
                SizedBox(height: Responsive.rh(8)),
                Row(
                  children: [
                    Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(14)),
                    SizedBox(width: Responsive.rw(4)),
                    Text(location, style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12))),
                  ],
                ),
                SizedBox(height: Responsive.rh(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date, style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12))),
                    Row(
                      children: [
                        Icon(Icons.favorite_border, color: ColorsApp.primary, size: Responsive.rw(16)),
                        SizedBox(width: Responsive.rw(4)),
                        Text("$likes Likes", style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}