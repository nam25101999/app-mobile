import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'my_trips_screen.dart'; // Nối luồng trở về màn hình My Trips

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({super.key});

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
          "Payment",
          style: TextStyle(
            color: ColorsApp.textDark,
            fontSize: Responsive.rw(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Responsive.rw(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==========================================
                    // STEPPER (Trạng thái: Bước 2)
                    // ==========================================
                    _buildStepper(step2Active: true),
                    SizedBox(height: Responsive.rh(25)),

                    // ==========================================
                    // TRIP CARD INFO
                    // ==========================================
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Responsive.rw(12)),
                        border: Border.all(color: ColorsApp.grayE8E8E8),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Hình ảnh + Avatar
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(Responsive.rw(12))),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1555921015-5532091f6026?q=80&w=800&fit=crop',
                                  height: Responsive.rh(120),
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
                                    Text("Hanoi, Vietnam", style: TextStyle(color: Colors.white, fontSize: Responsive.rw(12), fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: Responsive.rw(16),
                                bottom: -Responsive.rw(20), // Đè qua ảnh
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: ColorsApp.primary, width: 2),
                                  ),
                                  child: CircleAvatar(
                                    radius: Responsive.rw(20),
                                    backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Content chi tiết
                          Padding(
                            padding: EdgeInsets.all(Responsive.rw(16)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Responsive.rh(10)), // Bù chỗ cho Avatar
                                _buildInfoRow("Date", "Feb 2, 2020"),
                                SizedBox(height: Responsive.rh(12)),
                                _buildInfoRow("Time", "8:00AM - 10:00AM"),
                                SizedBox(height: Responsive.rh(12)),
                                _buildInfoRow("Guide", "Emmy", valueColor: ColorsApp.primary),
                                SizedBox(height: Responsive.rh(12)),
                                _buildInfoRow("Number of Travelers", "2"),
                                SizedBox(height: Responsive.rh(16)),
                                Text(
                                  "Attractions",
                                  style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.bold, color: ColorsApp.textDark),
                                ),
                                SizedBox(height: Responsive.rh(8)),
                                Wrap(
                                  spacing: Responsive.rw(10),
                                  runSpacing: Responsive.rh(10),
                                  children: [
                                    _buildAttractionChip("Ho Guom"),
                                    _buildAttractionChip("Ho Hoan Kiem"),
                                    _buildAttractionChip("Pho 12 Pho Kim Ma"),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // ==========================================
                          // TOTAL BLOCK (TỔNG KẾT THANH TOÁN)
                          // ==========================================
                          Container(
                            padding: EdgeInsets.all(Responsive.rw(16)),
                            decoration: const BoxDecoration(
                              border: Border(top: BorderSide(color: ColorsApp.grayE8E8E8)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total", style: TextStyle(fontSize: Responsive.rw(20), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
                                    Text("\$20.00", style: TextStyle(fontSize: Responsive.rw(20), fontWeight: FontWeight.bold, color: ColorsApp.primary)),
                                  ],
                                ),
                                SizedBox(height: Responsive.rh(8)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("50% payment", style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.textSecondary)),
                                    Text("\$10.00", style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.primary, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(height: Responsive.rh(4)),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("(You just need to pay upfront 50%)", style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.grayAFAFAF)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==========================================
            // NÚT CHECK OUT (Hoàn tất)
            // ==========================================
            Padding(
              padding: EdgeInsets.all(Responsive.rw(20)),
              child: SizedBox(
                width: double.infinity,
                height: Responsive.rh(50),
                child: ElevatedButton(
                  onPressed: () {
                    // Thanh toán thành công, xóa ngăn xếp và đi thẳng về MyTrips kèm cờ showSuccess
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MyTripsScreen(showSuccessBadge: true)),
                          (route) => route.isFirst,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Responsive.rw(8)),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "CHECK OUT",
                    style: TextStyle(
                      fontSize: Responsive.rw(14),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Khối Stepper tái sử dụng
  Widget _buildStepper({required bool step2Active}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Responsive.rw(16), height: Responsive.rw(16),
              decoration: BoxDecoration(shape: BoxShape.circle, color: ColorsApp.primary, border: Border.all(color: ColorsApp.primary.withOpacity(0.3), width: Responsive.rw(3))),
            ),
            Expanded(
              child: Container(
                height: 1, margin: EdgeInsets.symmetric(horizontal: Responsive.rw(8)),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Flex(
                      direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate((constraints.constrainWidth() / 6).floor(), (index) => SizedBox(width: 3, height: 1, child: DecoratedBox(decoration: BoxDecoration(color: step2Active ? ColorsApp.primary : ColorsApp.grayDBDBDB)))),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: Responsive.rw(16), height: Responsive.rw(16),
              decoration: BoxDecoration(shape: BoxShape.circle, color: step2Active ? ColorsApp.primary : ColorsApp.grayDBDBDB, border: Border.all(color: step2Active ? ColorsApp.primary.withOpacity(0.3) : Colors.transparent, width: Responsive.rw(3))),
            ),
          ],
        ),
        SizedBox(height: Responsive.rh(8)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Payment Method", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12), fontWeight: FontWeight.bold)),
            Text("Preview & Check out", style: TextStyle(color: step2Active ? ColorsApp.primary : ColorsApp.gray999, fontSize: Responsive.rw(12), fontWeight: step2Active ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
        Text(value, style: TextStyle(fontSize: Responsive.rw(14), color: valueColor ?? ColorsApp.textSecondary)),
      ],
    );
  }

  Widget _buildAttractionChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.rw(12), vertical: Responsive.rh(6)),
      decoration: BoxDecoration(
        color: ColorsApp.white,
        borderRadius: BorderRadius.circular(Responsive.rw(20)),
        border: Border.all(color: ColorsApp.grayE8E8E8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(12)),
          SizedBox(width: Responsive.rw(4)),
          Text(text, style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.textSecondary)),
        ],
      ),
    );
  }
}