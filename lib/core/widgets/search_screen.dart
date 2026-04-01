import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SearchResultsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white, // Hoặc ColorsApp.background tùy theme
      appBar: AppBar(
        backgroundColor: ColorsApp.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: ColorsApp.textDark, size: Responsive.rw(24)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.rh(10)),

            // ==========================================
            // THANH TÌM KIẾM
            // ==========================================
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Responsive.rw(8)),
                border: Border.all(color: ColorsApp.grayE8E8E8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true, // Bàn phím tự động bật lên
                style: TextStyle(
                  fontSize: Responsive.rw(16),
                  color: ColorsApp.textDark,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) => _goToResults(),
                decoration: InputDecoration(
                  hintText: "Where you want to explore",
                  hintStyle: TextStyle(color: ColorsApp.grayAFAFAF, fontSize: Responsive.rw(16)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(16)),
                ),
                cursorColor: ColorsApp.primary, // Con trỏ màu xanh
              ),
            ),
            SizedBox(height: Responsive.rh(30)),

            // ==========================================
            // ĐỊA ĐIỂM PHỔ BIẾN (POPULAR DESTINATIONS)
            // ==========================================
            Text(
              "Popular destinations",
              style: TextStyle(
                fontSize: Responsive.rw(14),
                color: ColorsApp.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Responsive.rh(16)),

            Wrap(
              spacing: Responsive.rw(10),
              runSpacing: Responsive.rh(12),
              children: [
                _buildPopularChip("Danang, Vietnam"),
                _buildPopularChip("Ho Chi Minh, Vietnam"),
                _buildPopularChip("Venice, Italy"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularChip(String text) {
    return GestureDetector(
      onTap: () {
        _searchController.text = text;
        _goToResults();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(10)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Responsive.rw(20)),
          border: Border.all(color: ColorsApp.grayE8E8E8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: Responsive.rw(14),
            color: ColorsApp.textDark,
          ),
        ),
      ),
    );
  }
}