import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class TourDetailScreen extends StatefulWidget {
  const TourDetailScreen({super.key});

  @override
  State<TourDetailScreen> createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  int _selectedDay = 1; // Quản lý trạng thái tab Ngày trong Lịch trình

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: Column(
        children: [
          // ==========================================
          // PHẦN NỘI DUNG CUỘN (SCROLLABLE CONTENT)
          // ==========================================
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero, // Để ảnh cover tràn lên trên cùng
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Ảnh Cover & Header Icons
                  _buildHeaderImage(context),

                  // 2. Thông tin cơ bản (Tên, Giá, Rate)
                  _buildBasicInfo(),

                  // 3. Thẻ Tóm tắt (Summary Card)
                  _buildSummaryCard(),

                  // 4. Lịch trình (Schedule & Timeline)
                  _buildScheduleSection(),

                  // 5. Bảng giá (Price Table)
                  _buildPriceSection(),

                  SizedBox(height: Responsive.rh(30)), // Khoảng trống trước đáy
                ],
              ),
            ),
          ),

          // ==========================================
          // NÚT BOOK NOW (CỐ ĐỊNH Ở ĐÁY)
          // ==========================================
          Container(
            padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(15)),
            decoration: BoxDecoration(
              color: ColorsApp.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5), // Đổ bóng lên trên
                ),
              ],
            ),
            child: SafeArea(
              top: false, // Chỉ áp dụng SafeArea cho phần đáy
              child: SizedBox(
                width: double.infinity,
                height: Responsive.rh(50),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Xử lý chức năng đặt tour
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Responsive.rw(8)),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "BOOK THIS TOUR",
                    style: TextStyle(
                      fontSize: Responsive.rw(14),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // WIDGET BUILDERS
  // ==========================================

  Widget _buildHeaderImage(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Responsive.rh(250),
      child: Stack(
        children: [
          // Ảnh nền
          Image.network(
            'https://images.unsplash.com/photo-1540202404-b71114228965?q=80&w=800&fit=crop', // Ảnh bể bơi/biển
            width: double.infinity,
            height: Responsive.rh(250),
            fit: BoxFit.cover,
          ),

          // Lớp phủ Gradient mờ ở trên cùng để dễ nhìn các icon màu trắng
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: Responsive.rh(100),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                ),
              ),
            ),
          ),

          // Các icon điều hướng & hành động
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(10), vertical: Responsive.rh(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nút Back
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: Responsive.rw(22)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // Nhóm nút bên phải
                  Row(
                    children: [
                      // Nút Share: Kích hoạt Bottom Sheet
                      _buildHeaderIconButton(
                        Icons.share_outlined,
                        onTap: () => _showShareBottomSheet(context),
                      ),
                      SizedBox(width: Responsive.rw(10)),
                      _buildHeaderIconButton(Icons.favorite_border),
                      SizedBox(width: Responsive.rw(10)),
                      _buildHeaderIconButton(Icons.bookmark_border),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Dấu gạch chuyển ảnh (Indicator)
          Positioned(
            bottom: Responsive.rh(15),
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndicator(isActive: true),
                SizedBox(width: Responsive.rw(4)),
                _buildIndicator(isActive: false),
                SizedBox(width: Responsive.rw(4)),
                _buildIndicator(isActive: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Responsive.rw(36),
        height: Responsive.rw(36),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2), // Nền mờ đục
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: Responsive.rw(20)),
      ),
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return Container(
      width: isActive ? Responsive.rw(16) : Responsive.rw(8),
      height: Responsive.rh(3),
      decoration: BoxDecoration(
        color: isActive ? ColorsApp.primary : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(Responsive.rw(4)),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Padding(
      padding: EdgeInsets.all(Responsive.rw(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tên Tour, Rate, Provider
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Da Nang - Ba Na - Hoi An",
                  style: TextStyle(
                    fontSize: Responsive.rw(20),
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.textDark,
                  ),
                ),
                SizedBox(height: Responsive.rh(8)),
                Row(
                  children: [
                    ...List.generate(5, (index) => Icon(Icons.star, color: ColorsApp.warning, size: Responsive.rw(14))),
                    SizedBox(width: Responsive.rw(8)),
                    Text(
                      "145 Reviews",
                      style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.gray999),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.rh(8)),
                Row(
                  children: [
                    Text(
                      "Provider",
                      style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.gray999),
                    ),
                    SizedBox(width: Responsive.rw(16)),
                    Text(
                      "dulichviet",
                      style: TextStyle(
                        fontSize: Responsive.rw(14),
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Giá tiền
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$400.00",
                style: TextStyle(
                  fontSize: Responsive.rw(20),
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.primary,
                ),
              ),
              SizedBox(height: Responsive.rh(4)),
              Text(
                "\$450.00",
                style: TextStyle(
                  fontSize: Responsive.rw(14),
                  color: ColorsApp.grayAFAFAF,
                  decoration: TextDecoration.lineThrough, // Gạch ngang giá cũ
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
      padding: EdgeInsets.all(Responsive.rw(16)),
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
          Text(
            "Summary",
            style: TextStyle(
              fontSize: Responsive.rw(18),
              fontWeight: FontWeight.bold,
              color: ColorsApp.textDark,
            ),
          ),
          SizedBox(height: Responsive.rh(16)),
          _buildSummaryRow("Itinerary", "Da Nang - Ba Na - Hoi An"),
          SizedBox(height: Responsive.rh(12)),
          _buildSummaryRow("Duration", "2 days, 2 nights"),
          SizedBox(height: Responsive.rh(12)),
          _buildSummaryRow("Departure Date", "Feb 12"),
          SizedBox(height: Responsive.rh(12)),
          _buildSummaryRow("Departure Place", "Ho Chi Minh"),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.gray999),
        ),
        SizedBox(height: Responsive.rh(4)),
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.rw(14),
            fontWeight: FontWeight.w500,
            color: ColorsApp.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleSection() {
    return Padding(
      padding: EdgeInsets.only(top: Responsive.rh(30), left: Responsive.rw(20), right: Responsive.rw(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề
          Row(
            children: [
              Icon(Icons.map_outlined, color: ColorsApp.textDark, size: Responsive.rw(24)),
              SizedBox(width: Responsive.rw(10)),
              Text(
                "Schedule",
                style: TextStyle(
                  fontSize: Responsive.rw(18),
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.rh(16)),

          // Tab chuyển ngày
          Row(
            children: [
              _buildTabButton("Day 1", 1),
              SizedBox(width: Responsive.rw(10)),
              _buildTabButton("Day 2", 2),
            ],
          ),
          SizedBox(height: Responsive.rh(20)),

          // Nội dung Lịch trình của Ngày đã chọn
          if (_selectedDay == 1) ...[
            Text(
              "Ho Chi Minh - Da Nang",
              style: TextStyle(
                fontSize: Responsive.rw(16),
                fontWeight: FontWeight.bold,
                color: ColorsApp.textDark,
              ),
            ),
            SizedBox(height: Responsive.rh(20)),

            // Danh sách Timeline
            _buildTimelineItem(
              time: "6:00AM",
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled.",
            ),
            _buildTimelineItem(
              time: "10:00AM",
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled.",
            ),
            _buildTimelineItem(
              time: "1:00PM",
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled.\n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets.",
            ),
            _buildTimelineItem(
              time: "8:00PM",
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled.",
              isLast: true,
            ),
          ] else ...[
            Center(child: Text("Day 2 itinerary goes here", style: TextStyle(color: ColorsApp.gray999))),
          ],
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int dayIndex) {
    bool isSelected = _selectedDay == dayIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = dayIndex;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive.rw(24), vertical: Responsive.rh(8)),
        decoration: BoxDecoration(
          color: isSelected ? ColorsApp.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(Responsive.rw(4)),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: Responsive.rw(14),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : ColorsApp.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem({required String time, required String description, bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cột chứa Dot tròn và Đường kẻ dọc
          Column(
            children: [
              Container(
                width: Responsive.rw(16),
                height: Responsive.rw(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsApp.primary,
                  border: Border.all(color: ColorsApp.white, width: Responsive.rw(3)),
                  boxShadow: [
                    BoxShadow(color: ColorsApp.primary.withOpacity(0.3), spreadRadius: 2),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: Responsive.rw(1),
                    color: ColorsApp.grayDBDBDB,
                    margin: EdgeInsets.only(top: Responsive.rh(4), bottom: Responsive.rh(4)),
                  ),
                ),
            ],
          ),
          SizedBox(width: Responsive.rw(16)),

          // Cột chứa Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: Responsive.rw(14),
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.primary,
                  ),
                ),
                SizedBox(height: Responsive.rh(8)),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: Responsive.rw(14),
                    color: ColorsApp.textSecondary,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: Responsive.rh(25)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Padding(
      padding: EdgeInsets.only(top: Responsive.rh(10), left: Responsive.rw(20), right: Responsive.rw(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề Price
          Row(
            children: [
              Icon(Icons.monetization_on_outlined, color: ColorsApp.textDark, size: Responsive.rw(24)),
              SizedBox(width: Responsive.rw(10)),
              Text(
                "Price",
                style: TextStyle(
                  fontSize: Responsive.rw(18),
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.rh(16)),

          // Bảng Giá (Pricing Table)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ColorsApp.grayDBDBDB),
              borderRadius: BorderRadius.circular(Responsive.rw(8)),
            ),
            child: Column(
              children: [
                _buildPriceRow("Adult (>10 years old)", "\$400.00"),
                const Divider(height: 1, color: ColorsApp.grayDBDBDB),
                _buildPriceRow("Child (5 - 10 years old)", "\$320.00"),
                const Divider(height: 1, color: ColorsApp.grayDBDBDB),
                _buildPriceRow("Child (<5 years old)", "Free", isBoldRight: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String leftText, String rightText, {bool isBoldRight = true}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Responsive.rh(15), horizontal: Responsive.rw(15)),
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
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Responsive.rh(15), horizontal: Responsive.rw(15)),
              child: Text(
                rightText,
                style: TextStyle(
                  fontSize: Responsive.rw(14),
                  fontWeight: isBoldRight ? FontWeight.bold : FontWeight.w500,
                  color: ColorsApp.textDark,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // XỬ LÝ BOTTOM SHEET (CHIA SẺ)
  // ==========================================
  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Background trong suốt để tạo hiệu ứng khối nổi (floating)
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Khối danh sách mạng xã hội
                Container(
                  padding: EdgeInsets.symmetric(vertical: Responsive.rh(20)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Responsive.rw(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Share on",
                        style: TextStyle(
                          fontSize: Responsive.rw(18),
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.textDark,
                        ),
                      ),
                      SizedBox(height: Responsive.rh(20)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Facebook
                            _buildSocialShareItem(
                              color: const Color(0xFF3B5998),
                              icon: Icons.facebook,
                              label: "Facebook",
                              iconColor: Colors.white,
                            ),
                            // Google
                            _buildSocialShareItem(
                              color: const Color(0xFFEA4335),
                              textIcon: "G+",
                              label: "Google",
                              iconColor: Colors.white,
                            ),
                            // Kakao Talk (Tùy chỉnh đặc biệt)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: Responsive.rw(50),
                                  height: Responsive.rw(50),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEE500),
                                    borderRadius: BorderRadius.circular(Responsive.rw(12)),
                                  ),
                                  child: Center(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(Icons.chat_bubble, color: Colors.black, size: Responsive.rw(30)),
                                        Text("TALK", style: TextStyle(color: const Color(0xFFFEE500), fontSize: Responsive.rw(8), fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: Responsive.rh(8)),
                                Text("Kakao Talk", style: TextStyle(fontSize: Responsive.rw(10), color: ColorsApp.textSecondary)),
                              ],
                            ),
                            // Whatsapp (Dùng icon chat thay thế)
                            _buildSocialShareItem(
                              color: const Color(0xFF25D366),
                              icon: Icons.chat,
                              label: "Whatsapp",
                              iconColor: Colors.white,
                            ),
                            // Twitter (Dùng icon flutter dash thay thế con chim)
                            _buildSocialShareItem(
                              color: const Color(0xFF1DA1F2),
                              icon: Icons.flutter_dash,
                              label: "Twitter",
                              iconColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.rh(10)),

                // Nút Cancel bồng bềnh
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Responsive.rh(16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Responsive.rw(16)),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: Responsive.rw(18),
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Hàm hỗ trợ vẽ icon mạng xã hội cơ bản
  Widget _buildSocialShareItem({
    required Color color,
    IconData? icon,
    String? textIcon,
    required String label,
    required Color iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Responsive.rw(50),
          height: Responsive.rw(50),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Responsive.rw(12)),
          ),
          child: Center(
            child: textIcon != null
                ? Text(
              textIcon,
              style: TextStyle(color: iconColor, fontSize: Responsive.rw(24), fontWeight: FontWeight.bold),
            )
                : Icon(icon, color: iconColor, size: Responsive.rw(28)),
          ),
        ),
        SizedBox(height: Responsive.rh(8)),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.rw(10), // Giảm chút font để vừa khít 5 icon 1 hàng
            color: ColorsApp.textSecondary,
          ),
        ),
      ],
    );
  }
}