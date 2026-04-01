import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'payment_checkout_screen.dart'; // Import thanh toán

class TripDetailScreen extends StatelessWidget {
  final bool isNextTrip;

  const TripDetailScreen({super.key, this.isNextTrip = false});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: AppBar(
        backgroundColor: ColorsApp.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: ColorsApp.textDark, size: Responsive.rw(24)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Trip Detail",
          style: TextStyle(
            color: ColorsApp.textDark,
            fontSize: Responsive.rw(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: ColorsApp.textDark, size: Responsive.rw(24)),
            onPressed: () => _showMoreBottomSheet(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // HEADER IMAGE & AVATAR
            // ==========================================
            _buildHeaderImage(),

            // ==========================================
            // TRIP INFORMATION
            // ==========================================
            Padding(
              padding: EdgeInsets.all(Responsive.rw(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Date", "Feb 2, 2020"),
                  SizedBox(height: Responsive.rh(15)),

                  _buildInfoRow("Time", "8:00AM - 10:00AM"),
                  SizedBox(height: Responsive.rh(15)),

                  _buildInfoRow("Guide", "Emmy", valueColor: ColorsApp.primary),
                  SizedBox(height: Responsive.rh(15)),

                  _buildInfoRow("Number of Travelers", "2"),
                  SizedBox(height: Responsive.rh(20)),

                  // Attractions
                  Text(
                    "Attractions",
                    style: TextStyle(
                      fontSize: Responsive.rw(16),
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.textDark,
                    ),
                  ),
                  SizedBox(height: Responsive.rh(12)),
                  Wrap(
                    spacing: Responsive.rw(10),
                    runSpacing: Responsive.rh(10),
                    children: [
                      _buildAttractionChip("Ho Guom"),
                      _buildAttractionChip("Ho Hoan Kiem"),
                      _buildAttractionChip("Pho 12 Pho Kim Ma"),
                    ],
                  ),
                  SizedBox(height: Responsive.rh(30)),

                  // Fee
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Fee",
                        style: TextStyle(
                          fontSize: Responsive.rw(20),
                          fontWeight: FontWeight.w600,
                          color: ColorsApp.textDark,
                        ),
                      ),
                      Text(
                        "\$20.00",
                        style: TextStyle(
                          fontSize: Responsive.rw(24),
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ==========================================
            // BOTTOM ACTION (MARK FINISHED or CHAT/PAY)
            // ==========================================
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(20)),
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
                top: false, // Chỉ padding khu vực dưới cùng
                child: isNextTrip
                    ? Row(
                  children: [
                    // Nút Chat
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Mở Chat
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: Responsive.rh(12)),
                          decoration: BoxDecoration(
                            color: ColorsApp.white,
                            borderRadius: BorderRadius.circular(Responsive.rw(8)),
                            border: Border.all(color: ColorsApp.primary),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_bubble_outline, color: ColorsApp.primary, size: Responsive.rw(18)),
                              SizedBox(width: Responsive.rw(8)),
                              Text("Chat", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(14), fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Responsive.rw(15)),
                    // Nút Pay
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PaymentCheckoutScreen()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: Responsive.rh(12)),
                          decoration: BoxDecoration(
                            color: ColorsApp.white,
                            borderRadius: BorderRadius.circular(Responsive.rw(8)),
                            border: Border.all(color: ColorsApp.primary),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.payment, color: ColorsApp.primary, size: Responsive.rw(18)),
                              SizedBox(width: Responsive.rw(8)),
                              Text("Pay", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(14), fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // TODO: Handle Mark Finished
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(12)),
                        decoration: BoxDecoration(
                          color: ColorsApp.white,
                          borderRadius: BorderRadius.circular(Responsive.rw(8)),
                          border: Border.all(color: ColorsApp.grayDBDBDB),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check, color: ColorsApp.textDark, size: Responsive.rw(20)),
                            SizedBox(width: Responsive.rw(8)),
                            Text(
                              "Mark Finished",
                              style: TextStyle(
                                fontSize: Responsive.rw(14),
                                color: ColorsApp.textDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET BUILDERS DÀNH CHO UI CHUNG
  // ==========================================

  Widget _buildHeaderImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Responsive.rw(30)), // Khoảng trống cho Avatar đè lên
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Responsive.rw(12)),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=800&fit=crop', // Cầu Rồng Hoàng Hôn
                    height: Responsive.rh(160),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Gradient mờ ở dưới đáy để làm nổi bật text
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Responsive.rh(50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(Responsive.rw(12))),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                      ),
                    ),
                  ),
                ),
                // Vị trí (Location)
                Positioned(
                  bottom: Responsive.rh(12),
                  left: Responsive.rw(16),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: Responsive.rw(16)),
                      SizedBox(width: Responsive.rw(4)),
                      Text(
                        "Danang, Vietnam",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.rw(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Avatar nằm đè lên góc dưới phải
          Positioned(
            right: Responsive.rw(16),
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorsApp.primary, width: Responsive.rw(3)),
              ),
              child: CircleAvatar(
                radius: Responsive.rw(30),
                backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.rw(16),
            fontWeight: FontWeight.w600,
            color: ColorsApp.textDark,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.rw(16),
            color: valueColor ?? ColorsApp.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAttractionChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.rw(12), vertical: Responsive.rh(8)),
      decoration: BoxDecoration(
        color: ColorsApp.white,
        borderRadius: BorderRadius.circular(Responsive.rw(20)),
        border: Border.all(color: ColorsApp.grayE8E8E8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(14)),
          SizedBox(width: Responsive.rw(4)),
          Text(
            text,
            style: TextStyle(
              fontSize: Responsive.rw(14),
              color: ColorsApp.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // BOTTOM SHEET & DIALOGS
  // ==========================================

  void _showMoreBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Nền trong suốt để tạo hiệu ứng khối nổi
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Khối Options (Edit / Delete)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Responsive.rw(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.edit_outlined, color: ColorsApp.textDark, size: Responsive.rw(20)),
                        title: Text("Edit This Trip", style: TextStyle(fontSize: Responsive.rw(16), color: ColorsApp.textDark)),
                        contentPadding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(4)),
                        onTap: () {
                          Navigator.pop(context);
                          // TODO: Xử lý chức năng Edit
                        },
                      ),
                      const Divider(height: 1, color: ColorsApp.grayDBDBDB),
                      ListTile(
                        leading: Icon(Icons.delete_outline, color: ColorsApp.textDark, size: Responsive.rw(20)),
                        title: Text("Delete This Trip", style: TextStyle(fontSize: Responsive.rw(16), color: ColorsApp.textDark)),
                        contentPadding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(4)),
                        onTap: () {
                          Navigator.pop(context); // Đóng Bottom Sheet
                          _showDeleteConfirmDialog(context); // Mở Dialog xác nhận
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.rh(10)),
                // Nút Cancel tách rời
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

  void _showDeleteConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Responsive.rw(12))),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: Responsive.rh(24), bottom: Responsive.rh(16), left: Responsive.rw(20), right: Responsive.rw(20)),
                child: Column(
                  children: [
                    Text(
                      "Delete This Trip",
                      style: TextStyle(fontSize: Responsive.rw(18), fontWeight: FontWeight.bold, color: ColorsApp.textDark),
                    ),
                    SizedBox(height: Responsive.rh(12)),
                    Text(
                      "Are you sure you want to delete this trip?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.textSecondary, height: 1.5),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: ColorsApp.grayDBDBDB),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: Responsive.rh(16))),
                        child: Text("Cancel", style: TextStyle(fontSize: Responsive.rw(16), fontWeight: FontWeight.w600, color: ColorsApp.primary)),
                      ),
                    ),
                    const VerticalDivider(width: 1, color: ColorsApp.grayDBDBDB),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // TODO: Xử lý logic xóa trip thực tế
                          Navigator.pop(context); // Đóng dialog
                          Navigator.pop(context); // Trở về màn hình trước đó
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: Responsive.rh(16))),
                        child: Text("Delete", style: TextStyle(fontSize: Responsive.rw(16), fontWeight: FontWeight.w600, color: ColorsApp.primary)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}