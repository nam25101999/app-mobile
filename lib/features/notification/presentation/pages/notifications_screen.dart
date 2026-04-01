import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

import 'package:demo/core/widgets/custom_bottom_nav.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _currentIndex = 3; // Mặc định chọn tab "Notification"

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: Column(
        children: [
          // ==========================================
          // 1. HEADER (Ảnh nền & Tiêu đề)
          // ==========================================
          _buildHeader(),

          // ==========================================
          // 2. DANH SÁCH THÔNG BÁO (Nội dung)
          // ==========================================
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNotificationItem(
                  avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
                  badgeIcon: Icons.location_on,
                  badgeColor: const Color(0xFF7CB342), // Màu xanh lá cây mạ
                  content: "Tuan Tran accepted your request for the trip in Danang, Vietnam on Jan 20, 2020",
                  date: "Jan 16",
                ),
                _buildNotificationItem(
                  avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
                  badgeIcon: Icons.insert_drive_file,
                  badgeColor: const Color(0xFFFFB300), // Màu vàng cam
                  content: "Emmy sent you an offer for the trip in Ho Chi Minh, Vietnam on Feb 12, 2020",
                  date: "Jan 16",
                ),
                _buildNotificationItem(
                  isSystemAvatar: true, // Dùng logo hệ thống thay vì ảnh user
                  badgeIcon: Icons.edit,
                  badgeColor: const Color(0xFF1E88E5), // Màu xanh dương
                  content: "Thanks! Your trip in Danang, Vietnam on Jan 20, 2020 has been finished. Please leave a review for the guide Tuan Tran.",
                  date: "Jan 24",
                  actionButton: ElevatedButton(
                    onPressed: () {
                      // TODO: Xử lý hành động Leave Review
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Responsive.rw(8)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(10)),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Leave Review",
                      style: TextStyle(
                        fontSize: Responsive.rw(14),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ==========================================
      // BOTTOM NAVIGATION BAR
      // ==========================================
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
      ),
    );
  }

  // ==========================================
  // WIDGET BUILDERS
  // ==========================================

  Widget _buildHeader() {
    return SizedBox(
      height: Responsive.rh(160),
      width: double.infinity,
      child: Stack(
        children: [
          // Ảnh nền Cầu Rồng Đà Nẵng
          Image.network(
            'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=800&fit=crop',
            width: double.infinity,
            height: Responsive.rh(160),
            fit: BoxFit.cover,
          ),
          // Lớp phủ tối mờ để làm nổi bật chữ
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.3), Colors.transparent],
              ),
            ),
          ),
          // Nội dung Header
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Notifications",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.rw(36),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Nút tìm kiếm (kéo nhẹ lên 1 chút cho cân đối với chữ to)
                  Padding(
                    padding: EdgeInsets.only(bottom: Responsive.rh(5)),
                    child: Container(
                      width: Responsive.rw(40),
                      height: Responsive.rw(40),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.search, color: Colors.white, size: Responsive.rw(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    String? avatarUrl,
    bool isSystemAvatar = false,
    required IconData badgeIcon,
    required Color badgeColor,
    required String content,
    required String date,
    Widget? actionButton,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(Responsive.rw(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Cụm Avatar + Badge Icon
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Avatar tròn
                  isSystemAvatar
                      ? Container(
                    width: Responsive.rw(50),
                    height: Responsive.rw(50),
                    decoration: const BoxDecoration(
                      color: ColorsApp.primary, // Màu xanh app
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      // Dùng icon tạm thay thế cho logo App
                      child: Icon(Icons.sentiment_satisfied_alt, color: Colors.white, size: Responsive.rw(30)),
                    ),
                  )
                      : CircleAvatar(
                    radius: Responsive.rw(25),
                    backgroundImage: NetworkImage(avatarUrl!),
                  ),

                  // Icon đính kèm (Badge)
                  Positioned(
                    right: -Responsive.rw(4),
                    bottom: -Responsive.rh(4),
                    child: Container(
                      width: Responsive.rw(22),
                      height: Responsive.rw(22),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: Responsive.rw(2)),
                      ),
                      child: Icon(
                        badgeIcon,
                        color: Colors.white,
                        size: Responsive.rw(12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: Responsive.rw(16)),

              // 2. Nội dung thông báo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: Responsive.rw(14),
                        color: ColorsApp.textDark,
                        height: 1.4, // Tạo khoảng cách dòng dễ nhìn
                      ),
                    ),
                    SizedBox(height: Responsive.rh(8)),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: Responsive.rw(12),
                        color: ColorsApp.gray999,
                      ),
                    ),

                    // 3. Nút Action (nếu có, VD: "Leave Review")
                    if (actionButton != null) ...[
                      SizedBox(height: Responsive.rh(12)),
                      actionButton,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        // Đường kẻ phân cách
        const Divider(height: 1, color: ColorsApp.grayDBDBDB),
      ],
    );
  }
}