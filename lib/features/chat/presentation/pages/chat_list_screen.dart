import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import '../../../../core/widgets/custom_bottom_nav.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int _currentIndex = 2; // Tab "Chat"

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: Column(
        children: [
          // ==========================================
          // 1. HEADER & SEARCH BAR
          // ==========================================
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Hình nền Header
              Container(
                width: double.infinity,
                height: Responsive.rh(180),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=800&fit=crop'), // Cầu Rồng
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Lớp phủ Gradient
              Container(
                width: double.infinity,
                height: Responsive.rh(180),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.4), Colors.transparent, Colors.black.withOpacity(0.2)],
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
                        "Chat",
                        style: TextStyle(color: Colors.white, fontSize: Responsive.rw(36), fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Responsive.rh(5)),
                        child: Container(
                          width: Responsive.rw(40), height: Responsive.rw(40),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                          child: Icon(Icons.search, color: Colors.white, size: Responsive.rw(20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Thanh Tìm kiếm (Chồng lên)
              Positioned(
                bottom: -Responsive.rh(25),
                left: Responsive.rw(20), right: Responsive.rw(20),
                child: Container(
                  height: Responsive.rh(50),
                  decoration: BoxDecoration(
                    color: ColorsApp.grayF5F5F5, // Màu nền search xám nhạt
                    borderRadius: BorderRadius.circular(Responsive.rw(25)), // Bo tròn nhiều
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Chat",
                      hintStyle: TextStyle(color: ColorsApp.gray777, fontSize: Responsive.rw(14)),
                      prefixIcon: Icon(Icons.search, color: ColorsApp.gray999, size: Responsive.rw(20)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(15)),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: Responsive.rh(40)), // Bù khoảng trống

          // ==========================================
          // 2. DANH SÁCH TIN NHẮN
          // ==========================================
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildChatItem(
                  avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
                  name: "Tuan Tran",
                  message: "It's a beautiful place",
                  time: "10:30 AM",
                ),
                _buildChatItem(
                  avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
                  name: "Emmy",
                  message: "We can start at 8am",
                  time: "", // Không hiện giờ vì có unread
                  unreadCount: 2,
                ),
                _buildChatItem(
                  avatar: 'https://randomuser.me/api/portraits/men/46.jpg',
                  name: "Khai Ho",
                  message: "See you tomorrow",
                  time: "11:30 AM",
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

  Widget _buildChatItem({required String avatar, required String name, required String message, required String time, int unreadCount = 0}) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatDetailScreen()));
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(15)),
            child: Row(
              children: [
                CircleAvatar(radius: Responsive.rw(25), backgroundImage: NetworkImage(avatar)),
                SizedBox(width: Responsive.rw(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(name, style: TextStyle(fontSize: Responsive.rw(16), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
                          if (unreadCount > 0)
                            Container(
                              padding: EdgeInsets.all(Responsive.rw(6)),
                              decoration: const BoxDecoration(color: ColorsApp.error, shape: BoxShape.circle),
                              child: Text(unreadCount.toString(), style: TextStyle(color: Colors.white, fontSize: Responsive.rw(10), fontWeight: FontWeight.bold)),
                            )
                          else
                            Text(time, style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.gray999)),
                        ],
                      ),
                      SizedBox(height: Responsive.rh(4)),
                      Text(message, style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: ColorsApp.grayDBDBDB, indent: Responsive.rw(80)), // Thụt lề divider
        ],
      ),
    );
  }
}