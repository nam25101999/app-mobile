import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class NewAttractionsScreen extends StatefulWidget {
  const NewAttractionsScreen({super.key});

  @override
  State<NewAttractionsScreen> createState() => _NewAttractionsScreenState();
}

class _NewAttractionsScreenState extends State<NewAttractionsScreen> {
  // Đặt giá trị rỗng để hiển thị placeholder "Type a Place" theo mockup mới
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Lắng nghe thay đổi text để đổi màu nút '+' nếu có nhập liệu
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.background, // Màu nền hơi xám nhẹ để khối search nổi bật
      appBar: AppBar(
        backgroundColor: ColorsApp.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: ColorsApp.textDark, size: Responsive.rw(24)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "New Attractions",
          style: TextStyle(
            color: ColorsApp.textDark,
            fontSize: Responsive.rw(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Xử lý hành động DONE
              Navigator.pop(context);
            },
            child: Text(
              "DONE",
              style: TextStyle(
                color: ColorsApp.primary,
                fontSize: Responsive.rw(14),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Responsive.rw(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // KHỐI THANH TÌM KIẾM (SEARCH BAR)
              // ==========================================
              Container(
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
                padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(8)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true, // Tự động bật bàn phím giống mockup
                        style: TextStyle(
                          fontSize: Responsive.rw(16),
                          color: ColorsApp.textDark,
                        ),
                        decoration: InputDecoration(
                          hintText: "Type a Place",
                          hintStyle: const TextStyle(color: ColorsApp.grayAFAFAF),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(10)),
                        ),
                      ),
                    ),

                    // Nút thêm (Add +)
                    GestureDetector(
                      onTap: () {
                        // TODO: Xử lý thêm địa điểm
                      },
                      child: Container(
                        width: Responsive.rw(28),
                        height: Responsive.rw(28),
                        decoration: BoxDecoration(
                          // Màu xám nếu ô text rỗng, xanh nếu có text
                          color: _searchController.text.isEmpty
                              ? ColorsApp.grayDBDBDB
                              : ColorsApp.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: Responsive.rw(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Responsive.rh(20)),

              // ==========================================
              // DANH SÁCH ĐỊA ĐIỂM ĐÃ THÊM
              // ==========================================
              Wrap(
                spacing: Responsive.rw(15),
                runSpacing: Responsive.rh(15),
                children: [
                  _buildAddedPlaceCard(
                    // Sử dụng ảnh quán cà phê làm placeholder minh hoạ cho "Cong Coffee"
                    image: 'https://images.unsplash.com/photo-1559925393-8be0ca47e58c?q=80&w=400&fit=crop',
                    title: "Cong Coffee",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET HỖ TRỢ
  // ==========================================

  // Widget vẽ thẻ địa điểm đã được thêm (có dấu tích xanh)
  Widget _buildAddedPlaceCard({required String image, required String title}) {
    // Tính toán độ rộng để chứa 2 thẻ trên 1 hàng
    final width = (Responsive.screenWidth - Responsive.rw(40) - Responsive.rw(15)) / 2;

    return Container(
      width: width,
      height: Responsive.rh(90), // Chiều cao giống các thẻ attraction ở màn hình trước
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.rw(8)),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Lớp phủ Gradient mờ ở dưới đáy để làm nổi bật chữ
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: Responsive.rh(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Responsive.rw(8)),
                  bottomRight: Radius.circular(Responsive.rw(8)),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                ),
              ),
            ),
          ),
          // Tiêu đề nằm ở góc dưới bên trái
          Positioned(
            bottom: Responsive.rh(8),
            left: Responsive.rw(8),
            right: Responsive.rw(8),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.rw(12),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Nút Checkmark ở góc trên bên phải
          Positioned(
            top: Responsive.rh(8),
            right: Responsive.rw(8),
            child: Container(
              width: Responsive.rw(20),
              height: Responsive.rw(20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsApp.primary, // Tích xanh mặc định cho item đã thêm
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: Responsive.rw(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}