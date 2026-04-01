import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'package:demo/core/widgets/custom_bottom_nav.dart';
import 'create_new_trip_screen.dart';
import 'trip_detail_screen.dart';
import 'payment_checkout_screen.dart';

class MyTripsScreen extends StatefulWidget {
  final bool showSuccessBadge; // Cờ hiệu để bật thông báo

  const MyTripsScreen({super.key, this.showSuccessBadge = false});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  int _currentIndex = 1;
  int _selectedTabIndex = 1; // 0: Current, 1: Next, 2: Past, 3: Wish List
  bool _showSuccess = false;

  final List<String> _tabs = ["Current Trips", "Next Trips", "Past Trips", "Wish List"];

  @override
  void initState() {
    super.initState();
    // Bật hẹn giờ hiển thị và tắt snackbar báo thành công
    if (widget.showSuccessBadge) {
      _showSuccess = true;
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          setState(() {
            _showSuccess = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.background,
      body: Stack(
        children: [
          Column(
            children: [
              // ==========================================
              // 1. HEADER (Ảnh nền & Tiêu đề)
              // ==========================================
              _buildHeader(),

              // ==========================================
              // 2. CUSTOM TAB BAR
              // ==========================================
              _buildCustomTabBar(),

              // ==========================================
              // 3. TAB CONTENT (Nội dung danh sách)
              // ==========================================
              Expanded(
                child: _buildTabContent(),
              ),
            ],
          ),

          // ==========================================
          // THÔNG BÁO THÀNH CÔNG (Sau khi thanh toán)
          // ==========================================
          if (_showSuccess)
            Positioned(
              top: Responsive.rh(50),
              left: Responsive.rw(15),
              right: Responsive.rw(15),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Responsive.rw(15), vertical: Responsive.rh(15)),
                decoration: BoxDecoration(
                  color: ColorsApp.success,
                  borderRadius: BorderRadius.circular(Responsive.rw(8)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
                  ],
                ),
                child: Text(
                  "Thanks! Check out successfully. Enjoy your trip!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.rw(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),

      // ==========================================
      // FLOATING ACTION BUTTON (Dấu +)
      // ==========================================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateNewTripScreen()),
          );
        },
        backgroundColor: ColorsApp.primary,
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
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
      height: Responsive.rh(180),
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=800&fit=crop',
            width: double.infinity,
            height: Responsive.rh(180),
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.3), Colors.transparent],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "My Trips",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.rw(36),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: Responsive.rw(40),
                    height: Responsive.rw(40),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.search, color: Colors.white, size: Responsive.rw(20)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: Responsive.rh(10)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.rw(15)),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            bool isSelected = _selectedTabIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = index),
              child: Container(
                margin: EdgeInsets.only(right: Responsive.rw(10)),
                padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(8)),
                decoration: BoxDecoration(
                  color: isSelected ? ColorsApp.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(Responsive.rw(4)),
                ),
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    fontSize: Responsive.rw(14),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : ColorsApp.gray999,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildCurrentTrips();
      case 1:
        return _buildNextTrips();
      case 2:
        return _buildPastTrips();
      case 3:
        return _buildWishList();
      default:
        return const SizedBox();
    }
  }

  // ==========================================
  // TAB 0: CURRENT TRIPS
  // ==========================================
  Widget _buildCurrentTrips() {
    return ListView(
      padding: EdgeInsets.all(Responsive.rw(20)),
      children: [
        _buildTripCard(
          image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=800&fit=crop',
          location: "Da Nang, Vietnam",
          title: "Dragon Bridge Trip",
          date: "Jan 30, 2020",
          time: "13:00 - 15:00",
          guideName: "Tuan Tran",
          guideAvatar: 'https://randomuser.me/api/portraits/men/32.jpg',
          topOverlayBadge: _buildOverlayBadge(Icons.check, "Mark Finished"),
          buttons: [
            _buildActionButton(
              "Detail",
              Icons.info_outline,
              outlined: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TripDetailScreen(isNextTrip: false)),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================
  // TAB 1: NEXT TRIPS
  // ==========================================
  Widget _buildNextTrips() {
    return ListView(
      padding: EdgeInsets.all(Responsive.rw(20)),
      children: [
        // 1. Thẻ bình thường
        _buildTripCard(
          image: 'https://images.unsplash.com/photo-1555921015-5532091f6026?q=80&w=800&fit=crop',
          location: "Hanoi, Vietnam",
          title: "Ho Guom Trip",
          date: "Feb 2, 2020",
          time: "8:00 - 10:00",
          guideName: "Emmy",
          guideAvatar: 'https://randomuser.me/api/portraits/women/44.jpg',
          showMenuDots: true,
          buttons: [
            _buildActionButton(
              "Detail",
              Icons.info_outline,
              outlined: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TripDetailScreen(isNextTrip: true)),
                );
              },
            ),
            _buildActionButton("Chat", Icons.chat_bubble_outline, outlined: true),
            _buildActionButton(
              "Pay",
              Icons.payment,
              outlined: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentCheckoutScreen()),
                );
              },
            ),
          ],
        ),
        SizedBox(height: Responsive.rh(20)),

        // 2. Thẻ Guide Rejected
        _buildTripCard(
          image: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=800&fit=crop',
          location: "Hanoi, Vietnam",
          title: "Ho Chi Minh Mausoleum",
          date: "Feb 2, 2020",
          time: "8:00 - 10:00",
          guideName: "Choose another Guide",
          isGuideRejected: true,
          showMenuDots: true,
          topBadge: _buildStatusBadge("Waiting", ColorsApp.gray999),
          buttons: [
            _buildActionButton(
              "Detail",
              Icons.info_outline,
              outlined: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TripDetailScreen(isNextTrip: true)),
                );
              },
            ),
            _buildActionButton("Choose another Guide", null, outlined: false, isFilledPrimary: true),
          ],
        ),
        SizedBox(height: Responsive.rh(20)),

        // 3. Thẻ Bidding
        _buildTripCard(
          image: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?q=80&w=800&fit=crop',
          location: "Ho Chi Minh, Vietnam",
          title: "Duc Ba Church",
          date: "Feb 2, 2020",
          time: "8:00 - 10:00",
          guideName: "Waiting for offers",
          isBidding: true,
          showMenuDots: true,
          topBadge: _buildStatusBadge("Bidding", ColorsApp.gray999),
          buttons: [
            _buildActionButton(
              "Detail",
              Icons.info_outline,
              outlined: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TripDetailScreen(isNextTrip: true)),
                );
              },
            ),
            _buildActionButton("Chat", Icons.chat_bubble_outline, outlined: true),
          ],
        ),
      ],
    );
  }

  // ==========================================
  // TAB 2: PAST TRIPS
  // ==========================================
  Widget _buildPastTrips() {
    return ListView(
      padding: EdgeInsets.all(Responsive.rw(20)),
      children: [
        _buildTripCard(
          image: 'https://images.unsplash.com/photo-1555126634-323283e090b0?q=80&w=800&fit=crop',
          location: "Hanoi, Vietnam",
          title: "Quoc Tu Giam Temple",
          date: "Feb 2, 2020",
          time: "8:00 - 10:00",
          guideName: "Emmy",
          guideAvatar: 'https://randomuser.me/api/portraits/women/44.jpg',
          showMenuDots: true,
        ),
        SizedBox(height: Responsive.rh(20)),
        _buildTripCard(
          image: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?q=80&w=800&fit=crop',
          location: "Ho Chi Minh, Vietnam",
          title: "Dinh Doc Lap",
          date: "Feb 2, 2020",
          time: "8:00 - 10:00",
          guideName: "Khai Ho",
          guideAvatar: 'https://randomuser.me/api/portraits/men/46.jpg',
          showMenuDots: true,
        ),
      ],
    );
  }

  // ==========================================
  // TAB 3: WISH LIST
  // ==========================================
  Widget _buildWishList() {
    return ListView(
      padding: EdgeInsets.all(Responsive.rw(20)),
      children: [
        _buildWishListCard(
          image: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?q=80&w=800&fit=crop',
          title: "Melbourne - Sydney",
          date: "Jan 30, 2020",
          days: "3 days",
          price: "\$600.00",
          likes: "1247",
          isFavorited: true,
        ),
        SizedBox(height: Responsive.rh(20)),
        _buildWishListCard(
          image: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=800&fit=crop',
          title: "Hanoi - Ha Long Bay",
          date: "Jan 30, 2020",
          days: "3 days",
          price: "\$300.00",
          likes: "1247",
          isFavorited: false,
        ),
      ],
    );
  }

  // ==========================================
  // HÀM HỖ TRỢ XÂY DỰNG TRIP CARD CHUNG
  // ==========================================
  Widget _buildTripCard({
    required String image,
    required String location,
    required String title,
    required String date,
    required String time,
    required String guideName,
    String? guideAvatar,
    bool showMenuDots = false,
    Widget? topBadge,
    Widget? topOverlayBadge,
    List<Widget>? buttons,
    bool isGuideRejected = false,
    bool isBidding = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.rw(12)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(Responsive.rw(12))),
                    child: Image.network(
                      image,
                      height: Responsive.rh(140),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0, left: 0, right: 0,
                    child: Container(
                      height: Responsive.rh(40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter, end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Responsive.rh(10), left: Responsive.rw(10),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white, size: Responsive.rw(14)),
                        SizedBox(width: Responsive.rw(4)),
                        Text(location, style: TextStyle(color: Colors.white, fontSize: Responsive.rw(12), fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  if (topBadge != null) Positioned(top: Responsive.rh(10), left: Responsive.rw(10), child: topBadge),
                  if (topOverlayBadge != null) Positioned(top: Responsive.rh(15), left: Responsive.rw(15), child: topOverlayBadge),
                  if (showMenuDots) Positioned(top: Responsive.rh(10), right: Responsive.rw(10), child: Icon(Icons.more_horiz, color: Colors.white, size: Responsive.rw(24))),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(Responsive.rw(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: Responsive.rw(16), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
                    SizedBox(height: Responsive.rh(8)),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: ColorsApp.gray999, size: Responsive.rw(14)),
                        SizedBox(width: Responsive.rw(6)),
                        Text(date, style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(14))),
                      ],
                    ),
                    SizedBox(height: Responsive.rh(6)),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: ColorsApp.gray999, size: Responsive.rw(14)),
                        SizedBox(width: Responsive.rw(6)),
                        Text(time, style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(14))),
                      ],
                    ),
                    SizedBox(height: Responsive.rh(6)),
                    Row(
                      children: [
                        Icon(Icons.person_outline, color: ColorsApp.gray999, size: Responsive.rw(14)),
                        SizedBox(width: Responsive.rw(6)),
                        Text(guideName, style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(14))),
                      ],
                    ),
                    if (buttons != null && buttons.isNotEmpty) ...[
                      SizedBox(height: Responsive.rh(16)),
                      Wrap(
                        spacing: Responsive.rw(10),
                        runSpacing: Responsive.rh(10),
                        children: buttons,
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: Responsive.rw(16),
            top: Responsive.rh(140) - Responsive.rw(30),
            child: _buildOverlappingAvatar(
              avatar: guideAvatar,
              isRejected: isGuideRejected,
              isBidding: isBidding,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlappingAvatar({String? avatar, bool isRejected = false, bool isBidding = false}) {
    double radius = Responsive.rw(30);

    if (isRejected) {
      return Container(
        width: radius * 2, height: radius * 2,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: ColorsApp.primary, width: 2),
        ),
        child: Icon(Icons.person, color: ColorsApp.primary, size: Responsive.rw(35)),
      );
    } else if (isBidding) {
      return SizedBox(
        width: radius * 3,
        height: radius * 2,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: CircleAvatar(radius: radius, backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/men/46.jpg')),
            ),
            Positioned(
              left: radius * 0.8,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                child: CircleAvatar(radius: radius, backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/44.jpg')),
              ),
            ),
            Positioned(
              left: radius * 1.6,
              child: Container(
                width: radius * 2, height: radius * 2,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                child: Center(child: Text("+3", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Responsive.rw(14)))),
              ),
            ),
          ],
        ),
      );
    } else if (avatar != null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorsApp.primary, width: 2),
        ),
        child: CircleAvatar(radius: radius, backgroundImage: NetworkImage(avatar)),
      );
    }
    return const SizedBox();
  }

  Widget _buildActionButton(String text, IconData? icon, {bool outlined = true, bool isFilledPrimary = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive.rw(12), vertical: Responsive.rh(6)),
        decoration: BoxDecoration(
          color: isFilledPrimary ? ColorsApp.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(Responsive.rw(4)),
          border: outlined ? Border.all(color: ColorsApp.primary) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: isFilledPrimary ? Colors.white : ColorsApp.primary, size: Responsive.rw(14)),
              SizedBox(width: Responsive.rw(4)),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: Responsive.rw(12),
                color: isFilledPrimary ? Colors.white : ColorsApp.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.rw(10), vertical: Responsive.rh(4)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(Responsive.rw(4)),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: Responsive.rw(10), fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildOverlayBadge(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.rw(12), vertical: Responsive.rh(8)),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(Responsive.rw(20)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: Responsive.rw(16)),
          SizedBox(width: Responsive.rw(6)),
          Text(text, style: TextStyle(color: Colors.white, fontSize: Responsive.rw(14), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildWishListCard({
    required String image,
    required String title,
    required String date,
    required String days,
    required String price,
    required String likes,
    bool isFavorited = false,
  }) {
    return Container(
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
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(top: Responsive.rh(10), right: Responsive.rw(10), child: Icon(Icons.bookmark, color: Colors.white, size: Responsive.rw(24))),
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
}