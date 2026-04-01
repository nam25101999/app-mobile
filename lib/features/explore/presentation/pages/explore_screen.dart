import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
// Import 2 trang vừa tạo
import 'package:demo/core/widgets/custom_bottom_nav.dart';
import 'guides_more_screen.dart';
import 'tours_more_screen.dart';
import 'package:demo/core/widgets/search_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _currentIndex = 0; // Index cho Bottom Navigation Bar

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
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=600&auto=format&fit=crop'), // Ảnh cầu Rồng Đà Nẵng (Placeholder)
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Lớp phủ Gradient tối màu ở trên cùng để làm nổi bật chữ
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
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
                // Nội dung Header (Thời tiết, Địa điểm, Tiêu đề)
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Responsive.rw(20),
                        vertical: Responsive.rh(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hàng trên cùng: Location
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white, size: Responsive.rw(16)),
                            SizedBox(width: Responsive.rw(4)),
                            Text(
                              "Da Nang",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Responsive.rw(14),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.rh(10)),
                        // Tiêu đề Explore & Thời tiết
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Explore",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Responsive.rw(36),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.cloud_queue,
                                    color: Colors.white, size: Responsive.rw(24)),
                                SizedBox(width: Responsive.rw(8)),
                                Text(
                                  "26°C",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Responsive.rw(24),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Thanh Tìm kiếm (Chồng lên giữa ranh giới Header và Body)
                Positioned(
                  bottom: -Responsive.rh(25),
                  left: Responsive.rw(20),
                  right: Responsive.rw(20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SearchScreen()),
                      );
                    },
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
                        enabled: false, // Vô hiệu hoá bàn phím ở màn hình này để dùng GestureDetector
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
                          contentPadding:
                          EdgeInsets.symmetric(vertical: Responsive.rh(15)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Khoảng trống để bù đắp cho thanh tìm kiếm bị đẩy xuống
            SizedBox(height: Responsive.rh(50)),

            // ==========================================
            // TOP JOURNEYS
            // ==========================================
            _buildSectionTitle("Top Journeys"),
            SizedBox(
              height: Responsive.rh(270),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
                children: [
                  _buildTopJourneyCard(
                    image: 'https://images.unsplash.com/photo-1540202404-b71114228965?q=80&w=400&fit=crop',
                    title: "Da Nang - Ba Na - Hoi An",
                    date: "Jan 30, 2020",
                    days: "3 days",
                    price: "\$400.00",
                    likes: "1247",
                  ),
                  _buildTopJourneyCard(
                    image: 'https://images.unsplash.com/photo-1528181304800-259b08848526?q=80&w=400&fit=crop',
                    title: "Thailand",
                    date: "Jan 30, 2020",
                    days: "3 days",
                    price: "\$600.00",
                    likes: "1247",
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(20)),

            // ==========================================
            // BEST GUIDES
            // ==========================================
            _buildSectionHeaderWithSeeMore(
              "Best Guides",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GuidesMoreScreen()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
              child: Wrap(
                spacing: Responsive.rw(15),
                runSpacing: Responsive.rh(15),
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
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(30)),

            // ==========================================
            // TOP EXPERIENCES
            // ==========================================
            _buildSectionTitle("Top Experiences"),
            SizedBox(
              height: Responsive.rh(280),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
                children: [
                  _buildTopExperienceCard(
                    bgImage: 'https://images.unsplash.com/photo-1555921015-5532091f6026?q=80&w=400&fit=crop',
                    avatarImage: 'https://randomuser.me/api/portraits/men/32.jpg',
                    guideName: "Tuan Tran",
                    title: "2 Hour Bicycle Tour\nexploring Hoian",
                    location: "Hoian, Vietnam",
                  ),
                  _buildTopExperienceCard(
                    bgImage: 'https://images.unsplash.com/photo-1565670105658-9562470eb06b?q=80&w=400&fit=crop',
                    avatarImage: 'https://randomuser.me/api/portraits/women/68.jpg',
                    guideName: "Linh Hana",
                    title: "1 day at Bana Hill",
                    location: "Bana, Vietnam",
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(20)),

            // ==========================================
            // FEATURED TOURS
            // ==========================================
            _buildSectionHeaderWithSeeMore(
              "Featured Tours",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ToursMoreScreen()),
                );
              },
            ),
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
                    isFavorited: true, // Heart màu xanh
                  ),
                  _buildFeaturedTourCard(
                    image: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=600&fit=crop',
                    title: "Hanoi - Ha Long Bay",
                    date: "Jan 30, 2020",
                    days: "3 days",
                    price: "\$300.00",
                    likes: "1247",
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(20)),

            // ==========================================
            // TRAVEL NEWS
            // ==========================================
            _buildSectionHeaderWithSeeMore("Travel News"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
              child: Column(
                children: [
                  _buildTravelNewsCard(
                    title: "New Destination in Danang City",
                    date: "Feb 5, 2020",
                    image: 'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?q=80&w=600&fit=crop',
                  ),
                  _buildTravelNewsCard(
                    title: "\$1 Flight Ticket",
                    date: "Feb 5, 2020",
                    image: 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?q=80&w=600&fit=crop',
                  ),
                  _buildTravelNewsCard(
                    title: "Visit Korea in this Tet Holiday",
                    date: "Jan 26, 2020",
                    image: 'https://images.unsplash.com/photo-1546874177-9e664107314e?q=80&w=600&fit=crop',
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(40)),
          ],
        ),
      ),

      // ==========================================
      // BOTTOM NAVIGATION BAR
      // ==========================================
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
      ),
    );
  }

  // Tiêu đề Section cơ bản
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
          left: Responsive.rw(20), right: Responsive.rw(20), bottom: Responsive.rh(15)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: Responsive.rw(20),
          fontWeight: FontWeight.bold,
          color: ColorsApp.textDark,
        ),
      ),
    );
  }

  // Tiêu đề Section kèm nút "SEE MORE" có sự kiện onTap
  Widget _buildSectionHeaderWithSeeMore(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: EdgeInsets.only(
          left: Responsive.rw(20), right: Responsive.rw(20), bottom: Responsive.rh(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.rw(20),
              fontWeight: FontWeight.bold,
              color: ColorsApp.textDark,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "SEE MORE",
              style: TextStyle(
                fontSize: Responsive.rw(12),
                fontWeight: FontWeight.w600,
                color: ColorsApp.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị sao (Rating)
  Widget _buildStars(String likesOrReviews) {
    return Row(
      children: [
        ...List.generate(
          5,
              (index) => Icon(Icons.star, color: ColorsApp.warning, size: Responsive.rw(12)),
        ),
        SizedBox(width: Responsive.rw(4)),
        Text(
          "$likesOrReviews ${likesOrReviews.length > 3 ? 'likes' : 'Reviews'}", // Tự động đổi chữ tùy theo context mockup
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.rw(10),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Card cho Top Journeys
  Widget _buildTopJourneyCard({
    required String image,
    required String title,
    required String date,
    required String days,
    required String price,
    required String likes,
  }) {
    return Container(
      width: Responsive.rw(200),
      margin: EdgeInsets.only(right: Responsive.rw(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.rw(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh Cover + Nút Bookmark + Sao đánh giá
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Responsive.rw(12)),
                  topRight: Radius.circular(Responsive.rw(12)),
                ),
                child: Image.network(
                  image,
                  height: Responsive.rh(130),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient Overlay mờ dưới đáy ảnh cho phần Sao
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: Responsive.rh(40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Responsive.rh(10),
                right: Responsive.rw(10),
                child: Icon(Icons.bookmark_border, color: Colors.white, size: Responsive.rw(20)),
              ),
              Positioned(
                bottom: Responsive.rh(10),
                left: Responsive.rw(10),
                child: _buildStars(likes),
              ),
            ],
          ),
          // Thông tin Text
          Padding(
            padding: EdgeInsets.all(Responsive.rw(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.rw(14),
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Responsive.rh(8)),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: ColorsApp.gray999, size: Responsive.rw(12)),
                    SizedBox(width: Responsive.rw(4)),
                    Text(
                      date,
                      style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12)),
                    ),
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
                        Text(
                          days,
                          style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12)),
                        ),
                      ],
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        color: ColorsApp.primary,
                        fontSize: Responsive.rw(14),
                        fontWeight: FontWeight.bold,
                      ),
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

  // Card cho Best Guides (Grid 2 cột)
  Widget _buildBestGuideCard({
    required String image,
    required String name,
    required String location,
    required String reviews,
  }) {
    // Kích thước ô dựa trên màn hình trừ đi padding và khoảng cách
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
                child: Image.network(
                  image,
                  height: width, // Dạng hình vuông
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: Responsive.rh(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Responsive.rw(12)),
                      bottomRight: Radius.circular(Responsive.rw(12)),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: Responsive.rh(10),
                left: Responsive.rw(10),
                child: _buildStars(reviews),
              ),
            ],
          ),
          SizedBox(height: Responsive.rh(8)),
          Text(
            name,
            style: TextStyle(
              fontSize: Responsive.rw(14),
              fontWeight: FontWeight.bold,
              color: ColorsApp.textDark,
            ),
          ),
          SizedBox(height: Responsive.rh(4)),
          Row(
            children: [
              Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(12)),
              SizedBox(width: Responsive.rw(4)),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    color: ColorsApp.primary,
                    fontSize: Responsive.rw(12),
                  ),
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

  // Card cho Top Experiences
  Widget _buildTopExperienceCard({
    required String bgImage,
    required String avatarImage,
    required String guideName,
    required String title,
    required String location,
  }) {
    return Container(
      width: Responsive.rw(200),
      margin: EdgeInsets.only(right: Responsive.rw(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Responsive.rw(12)),
                child: Image.network(
                  bgImage,
                  height: Responsive.rh(180),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Avatar xếp chồng lên rìa dưới
              Positioned(
                bottom: -Responsive.rh(20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorsApp.primary, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: Responsive.rw(24),
                        backgroundImage: NetworkImage(avatarImage),
                      ),
                    ),
                    // Tên guide chèn dưới avatar
                    Container(
                      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                      padding: EdgeInsets.symmetric(horizontal: Responsive.rw(10), vertical: Responsive.rh(4)),
                      decoration: BoxDecoration(
                        color: ColorsApp.primary,
                        borderRadius: BorderRadius.circular(Responsive.rw(10)),
                      ),
                      child: Text(
                        guideName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.rw(10),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.rh(20)), // Bù khoảng trống cho phần tràn avatar
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.rw(14),
              fontWeight: FontWeight.bold,
              color: ColorsApp.textDark,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Responsive.rh(8)),
          Row(
            children: [
              Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(12)),
              SizedBox(width: Responsive.rw(4)),
              Text(
                location,
                style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card cho Featured Tours
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
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Responsive.rw(12)),
                  topRight: Radius.circular(Responsive.rw(12)),
                ),
                child: Image.network(
                  image,
                  height: Responsive.rh(140),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: Responsive.rh(40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Responsive.rh(10),
                right: Responsive.rw(10),
                child: Icon(Icons.bookmark_border, color: Colors.white, size: Responsive.rw(20)),
              ),
              Positioned(
                bottom: Responsive.rh(10),
                left: Responsive.rw(10),
                child: _buildStars(likes),
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
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Responsive.rw(16),
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.textDark,
                      ),
                    ),
                    Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: ColorsApp.primary,
                      size: Responsive.rw(20),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.rh(8)),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: ColorsApp.gray999, size: Responsive.rw(12)),
                    SizedBox(width: Responsive.rw(4)),
                    Text(
                      date,
                      style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12)),
                    ),
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
                        Text(
                          days,
                          style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12)),
                        ),
                      ],
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        color: ColorsApp.primary,
                        fontSize: Responsive.rw(16),
                        fontWeight: FontWeight.bold,
                      ),
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

  // Card cho Travel News
  Widget _buildTravelNewsCard({
    required String title,
    required String date,
    required String image,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.rh(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.rw(14),
              fontWeight: FontWeight.bold,
              color: ColorsApp.textDark,
            ),
          ),
          SizedBox(height: Responsive.rh(4)),
          Text(
            date,
            style: TextStyle(
              fontSize: Responsive.rw(12),
              color: ColorsApp.gray999,
            ),
          ),
          SizedBox(height: Responsive.rh(10)),
          ClipRRect(
            borderRadius: BorderRadius.circular(Responsive.rw(12)),
            child: Image.network(
              image,
              height: Responsive.rh(120),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}