import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class GuidePageScreen extends StatefulWidget {
  const GuidePageScreen({super.key});

  @override
  State<GuidePageScreen> createState() => _GuidePageScreenState();
}

class _GuidePageScreenState extends State<GuidePageScreen> {
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
            // HEADER (COVER IMAGE & AVATAR)
            // ==========================================
            _buildHeader(),

            // ==========================================
            // BODY CONTENT
            // ==========================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Thông tin chung ---
                  _buildProfileInfo(),
                  SizedBox(height: Responsive.rh(20)),

                  // --- Giới thiệu ngắn ---
                  Text(
                    "Short introduction: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    style: TextStyle(
                      fontSize: Responsive.rw(14),
                      color: ColorsApp.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: Responsive.rh(20)),

                  // --- Video Thumbnail ---
                  _buildVideoThumbnail(),
                  SizedBox(height: Responsive.rh(20)),

                  // --- Bảng giá (Pricing Table) ---
                  _buildPricingTable(),
                  SizedBox(height: Responsive.rh(30)),

                  // --- Trải nghiệm (My Experiences) ---
                  Text(
                    "My Experiences",
                    style: TextStyle(
                      fontSize: Responsive.rw(20),
                      fontWeight: FontWeight.bold,
                      color: ColorsApp.textDark,
                    ),
                  ),
                  SizedBox(height: Responsive.rh(15)),

                  _buildExperienceCard(
                    mainImage: 'https://images.unsplash.com/photo-1555921015-5532091f6026?q=80&w=600&fit=crop', // Hội An
                    subImage1: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=400&fit=crop', // Thuyền 1
                    subImage2: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=400&fit=crop', // Thuyền 2
                    title: "2 Hour Bicycle Tour exploring Hoian",
                    location: "Hoian, Vietnam",
                    date: "Jan 25, 2020",
                    likes: "1234",
                  ),
                  SizedBox(height: Responsive.rh(20)),

                  _buildExperienceCard(
                    mainImage: 'https://images.unsplash.com/photo-1555126634-323283e090b0?q=80&w=600&fit=crop', // Bánh bột lọc / Đồ ăn
                    subImage1: 'https://images.unsplash.com/photo-1550461716-bf9c735d46e3?q=80&w=400&fit=crop', // Thịt nướng
                    subImage2: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?q=80&w=400&fit=crop', // Phở / Bún
                    title: "Food tour in Danang",
                    location: "Danang, Vietnam",
                    date: "Jan 20, 2020",
                    likes: "234",
                  ),
                  SizedBox(height: Responsive.rh(30)),

                  // --- Đánh giá (Reviews) ---
                  _buildSectionHeaderWithSeeMore("Reviews"),
                  _buildReviewItem(
                    avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
                    name: "Pena Valdez",
                    date: "Jan 22, 2020",
                    content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
                  ),
                  _buildReviewItem(
                    avatar: 'https://randomuser.me/api/portraits/women/68.jpg',
                    name: "Daehyun",
                    date: "Jan 22, 2020",
                    content: "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum'",
                  ),
                  _buildReviewItem(
                    avatar: 'https://randomuser.me/api/portraits/men/46.jpg',
                    name: "Burns Marks",
                    date: "Jan 22, 2020",
                    content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
                  ),
                  SizedBox(height: Responsive.rh(40)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET BUILDERS
  // ==========================================

  Widget _buildHeader() {
    return Container(
      // Padding bottom để chừa chỗ cho Avatar đè xuống dưới
      margin: EdgeInsets.only(
        bottom: Responsive.rh(45),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ảnh Cover
          Image.network(
            'https://images.unsplash.com/photo-1476611317561-60117649dd94?q=80&w=800&fit=crop', // Đường cây mùa thu
            width: double.infinity,
            height: Responsive.rh(200),
            fit: BoxFit.cover,
          ),

          // Nút Back
          Positioned(
            top: Responsive.rh(50), // SafeArea padding
            left: Responsive.rw(15),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(Responsive.rw(8)),
                child: Icon(Icons.arrow_back_ios, color: Colors.white, size: Responsive.rw(20)),
              ),
            ),
          ),

          // Avatar chèn ở góc dưới bên trái
          Positioned(
            bottom: -Responsive.rh(40), // Đẩy 1 nửa xuống dưới
            left: Responsive.rw(20),
            child: Container(
              padding: EdgeInsets.all(Responsive.rw(4)), // Viền trắng
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: Responsive.rw(40),
                backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'), // Tuan Tran Avatar
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tên và Nút
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tuan Tran",
              style: TextStyle(
                fontSize: Responsive.rw(28),
                fontWeight: FontWeight.bold,
                color: ColorsApp.textDark,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.primary,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(12)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Responsive.rw(6)),
                ),
              ),
              child: Text(
                "CHOOSE THIS GUIDE",
                style: TextStyle(
                  fontSize: Responsive.rw(12),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.rh(8)),

        // Đánh giá
        Row(
          children: [
            ...List.generate(5, (index) => Icon(Icons.star, color: ColorsApp.warning, size: Responsive.rw(14))),
            SizedBox(width: Responsive.rw(8)),
            Text(
              "127 Reviews",
              style: TextStyle(
                fontSize: Responsive.rw(12),
                color: ColorsApp.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.rh(12)),

        // Ngôn ngữ (Pills)
        Wrap(
          spacing: Responsive.rw(8),
          children: [
            _buildLanguagePill("Vietnamese"),
            _buildLanguagePill("English"),
            _buildLanguagePill("Korean"),
          ],
        ),
        SizedBox(height: Responsive.rh(12)),

        // Vị trí
        Row(
          children: [
            Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(16)),
            SizedBox(width: Responsive.rw(4)),
            Text(
              "Danang, Vietnam",
              style: TextStyle(
                fontSize: Responsive.rw(14),
                fontWeight: FontWeight.w500,
                color: ColorsApp.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguagePill(String language) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.rw(12), vertical: Responsive.rh(6)),
      decoration: BoxDecoration(
        color: ColorsApp.grayF5F5F5,
        borderRadius: BorderRadius.circular(Responsive.rw(20)),
        border: Border.all(color: ColorsApp.grayE8E8E8),
      ),
      child: Text(
        language,
        style: TextStyle(
          fontSize: Responsive.rw(12),
          color: ColorsApp.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildVideoThumbnail() {
    return Container(
      width: double.infinity,
      height: Responsive.rh(180),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.rw(12)),
        image: const DecorationImage(
          image: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'), // Lấy tạm ảnh avatar làm thumbnail video
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: Responsive.rw(50),
          height: Responsive.rw(50),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.play_arrow, color: ColorsApp.primary, size: Responsive.rw(30)),
        ),
      ),
    );
  }

  Widget _buildPricingTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsApp.grayDBDBDB),
        borderRadius: BorderRadius.circular(Responsive.rw(8)),
      ),
      child: Column(
        children: [
          _buildTableRow("1 - 3 Travelers", "\$10/ hour", isFirst: true),
          const Divider(height: 1, color: ColorsApp.grayDBDBDB),
          _buildTableRow("4 - 6 Travelers", "\$14/ hour"),
          const Divider(height: 1, color: ColorsApp.grayDBDBDB),
          _buildTableRow("7 - 9 Travelers", "\$17/ hour"),
        ],
      ),
    );
  }

  Widget _buildTableRow(String leftText, String rightText, {bool isFirst = false}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Responsive.rh(15), horizontal: Responsive.rw(20)),
              child: Text(
                leftText,
                style: TextStyle(
                  fontSize: Responsive.rw(14),
                  color: ColorsApp.textSecondary,
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 1, color: ColorsApp.grayDBDBDB),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Responsive.rh(15), horizontal: Responsive.rw(20)),
              child: Text(
                rightText,
                style: TextStyle(
                  fontSize: Responsive.rw(14),
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.textDark,
                ),
                textAlign: TextAlign.center, // Căn giữa cột phải giống thiết kế
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard({
    required String mainImage,
    required String subImage1,
    required String subImage2,
    required String title,
    required String location,
    required String date,
    required String likes,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.rw(12)),
        border: Border.all(color: ColorsApp.grayE8E8E8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Layout 3 ảnh: 1 lớn bên trái, 2 nhỏ bên phải
          SizedBox(
            height: Responsive.rh(160),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(Responsive.rw(12))),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(mainImage, fit: BoxFit.cover, height: double.infinity),
                  ),
                  SizedBox(width: Responsive.rw(2)), // Khe hở trắng
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(subImage1, fit: BoxFit.cover, width: double.infinity),
                        ),
                        SizedBox(height: Responsive.rh(2)), // Khe hở trắng
                        Expanded(
                          child: Image.network(subImage2, fit: BoxFit.cover, width: double.infinity),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Chi tiết text
          Padding(
            padding: EdgeInsets.all(Responsive.rw(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.rw(16),
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.textDark,
                  ),
                ),
                SizedBox(height: Responsive.rh(8)),
                Row(
                  children: [
                    Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(14)),
                    SizedBox(width: Responsive.rw(4)),
                    Text(
                      location,
                      style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12)),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.rh(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12)),
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite_border, color: ColorsApp.primary, size: Responsive.rw(16)),
                        SizedBox(width: Responsive.rw(4)),
                        Text(
                          "$likes Likes",
                          style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12)),
                        ),
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

  Widget _buildSectionHeaderWithSeeMore(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.rh(15)),
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
          Text(
            "SEE MORE",
            style: TextStyle(
              fontSize: Responsive.rw(12),
              fontWeight: FontWeight.w600,
              color: ColorsApp.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem({
    required String avatar,
    required String name,
    required String date,
    required String content,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.rh(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: Responsive.rw(20),
                backgroundImage: NetworkImage(avatar),
              ),
              SizedBox(width: Responsive.rw(12)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      ...List.generate(5, (index) => Icon(Icons.star, color: ColorsApp.warning, size: Responsive.rw(12))),
                      SizedBox(width: Responsive.rw(8)),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: Responsive.rw(12),
                          color: ColorsApp.gray999,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Responsive.rh(12)),
          Text(
            content,
            style: TextStyle(
              fontSize: Responsive.rw(14),
              color: ColorsApp.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}