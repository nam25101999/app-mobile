import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController(text: "Danang, Vietnam");

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
      ),
      body: Column(
        children: [
          // ==========================================
          // THANH TÌM KIẾM VÀ BỘ LỌC
          // ==========================================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsApp.grayF5F5F5,
                      borderRadius: BorderRadius.circular(Responsive.rw(8)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.textDark),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(14)),
                        suffixIcon: IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(Responsive.rw(4)),
                            decoration: const BoxDecoration(
                              color: ColorsApp.gray999,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close, color: Colors.white, size: Responsive.rw(12)),
                          ),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.rw(16)),
                // Nút Bộ lọc (Filter)
                GestureDetector(
                  onTap: () => _showFilterBottomSheet(context),
                  child: Icon(Icons.tune, color: ColorsApp.textDark, size: Responsive.rw(26)),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.rh(20)),

          // ==========================================
          // NỘI DUNG KẾT QUẢ TÌM KIẾM
          // ==========================================
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- GUIDES IN DANANG ---
                  _buildSectionHeaderWithSeeMore("Guides in Danang"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
                    child: Wrap(
                      spacing: Responsive.rw(15),
                      runSpacing: Responsive.rh(20),
                      children: [
                        _buildBestGuideCard(
                          image: 'https://randomuser.me/api/portraits/men/32.jpg',
                          name: "Tuan Tran",
                          location: "Danang, Vietnam",
                          reviews: "127",
                        ),
                        _buildBestGuideCard(
                          image: 'https://randomuser.me/api/portraits/women/68.jpg',
                          name: "Linh Hana",
                          location: "Danang, Vietnam",
                          reviews: "127",
                        ),
                        _buildBestGuideCard(
                          image: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=400&fit=crop',
                          name: "Tuan Tran",
                          location: "Danang, Vietnam",
                          reviews: "127",
                        ),
                        _buildBestGuideCard(
                          image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=400&fit=crop',
                          name: "Linh Hana",
                          location: "Danang, Vietnam",
                          reviews: "127",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.rh(30)),

                  // --- TOURS IN DANANG ---
                  _buildSectionHeaderWithSeeMore("Tours in Danang"),
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
                          isFavorited: true,
                        ),
                        _buildFeaturedTourCard(
                          image: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=600&fit=crop',
                          title: "Hanoi - Ha Long Bay",
                          date: "Jan 30, 2020",
                          days: "3 days",
                          price: "\$300.00",
                          likes: "1247",
                        ),
                        _buildFeaturedTourCard(
                          image: 'https://images.unsplash.com/photo-1576487248805-4c6e5ce6165e?q=80&w=600&fit=crop', // Sunrise
                          title: "Da Nang - Ba Na - Hoi An",
                          date: "Jan 30, 2020",
                          days: "3 days",
                          price: "\$400.00",
                          likes: "1247",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.rh(40)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // HÀM HIỂN THỊ BOTTOM SHEET (FILTERS)
  // ==========================================
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép kéo cao hơn
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              bool isGuidesTabActive = true; // Mặc định Guides tab

              // Hàm hỗ trợ vẽ Label
              Widget buildLabel(String text) {
                return Padding(
                  padding: EdgeInsets.only(bottom: Responsive.rh(10), top: Responsive.rh(20)),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: Responsive.rw(14),
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.textDark,
                    ),
                  ),
                );
              }

              // Hàm hỗ trợ vẽ Chip ngôn ngữ
              Widget buildLanguageChip(String lang, bool isSelected) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(8)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Responsive.rw(20)),
                    border: Border.all(color: isSelected ? ColorsApp.primary : ColorsApp.grayDBDBDB),
                  ),
                  child: Text(
                    lang,
                    style: TextStyle(
                      fontSize: Responsive.rw(14),
                      color: isSelected ? ColorsApp.primary : ColorsApp.textDark,
                    ),
                  ),
                );
              }

              return Container(
                height: MediaQuery.of(context).size.height * 0.75, // Cao 75% màn hình
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(Responsive.rw(20))),
                ),
                child: Column(
                  children: [
                    // --- Header của Bottom Sheet ---
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Responsive.rw(10), vertical: Responsive.rh(10)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(Icons.close, color: ColorsApp.gray777, size: Responsive.rw(20)),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          Text(
                            "Filters",
                            style: TextStyle(
                              fontSize: Responsive.rw(16),
                              fontWeight: FontWeight.bold,
                              color: ColorsApp.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: ColorsApp.grayDBDBDB),

                    // --- Nội dung Form Lọc ---
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(Responsive.rw(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tab Guides / Tours
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => setModalState(() => isGuidesTabActive = true),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Responsive.rw(24), vertical: Responsive.rh(10)),
                                    decoration: BoxDecoration(
                                      color: isGuidesTabActive ? ColorsApp.primary : Colors.white,
                                      borderRadius: BorderRadius.circular(Responsive.rw(8)),
                                      border: isGuidesTabActive ? null : Border.all(color: ColorsApp.grayDBDBDB),
                                    ),
                                    child: Text(
                                      "Guides",
                                      style: TextStyle(
                                        color: isGuidesTabActive ? Colors.white : ColorsApp.textDark,
                                        fontWeight: isGuidesTabActive ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Responsive.rw(12)),
                                GestureDetector(
                                  onTap: () => setModalState(() => isGuidesTabActive = false),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Responsive.rw(24), vertical: Responsive.rh(10)),
                                    decoration: BoxDecoration(
                                      color: !isGuidesTabActive ? ColorsApp.primary : Colors.white,
                                      borderRadius: BorderRadius.circular(Responsive.rw(8)),
                                      border: !isGuidesTabActive ? null : Border.all(color: ColorsApp.grayDBDBDB),
                                    ),
                                    child: Text(
                                      "Tours",
                                      style: TextStyle(
                                        color: !isGuidesTabActive ? Colors.white : ColorsApp.textDark,
                                        fontWeight: !isGuidesTabActive ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Date
                            buildLabel("Date"),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "mm/dd/yy",
                                hintStyle: TextStyle(color: ColorsApp.grayAFAFAF, fontSize: Responsive.rw(14)),
                                prefixIcon: Icon(Icons.calendar_today, color: ColorsApp.gray999, size: Responsive.rw(18)),
                                prefixIconConstraints: BoxConstraints(minWidth: Responsive.rw(30)),
                                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: ColorsApp.grayDBDBDB)),
                                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: ColorsApp.primary)),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(8)),
                              ),
                            ),

                            // Guide's Language
                            buildLabel("Guide's Language"),
                            Wrap(
                              spacing: Responsive.rw(10),
                              runSpacing: Responsive.rh(10),
                              children: [
                                buildLanguageChip("Vietnamese", false),
                                buildLanguageChip("English", false),
                                buildLanguageChip("Korean", false),
                                buildLanguageChip("Spanish", false),
                                buildLanguageChip("French", false),
                              ],
                            ),

                            // Fee
                            buildLabel("Fee"),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Fee",
                                hintStyle: TextStyle(color: ColorsApp.grayAFAFAF, fontSize: Responsive.rw(14)),
                                prefixIcon: Text("\$  ", style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(14))),
                                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                                suffixIcon: Text("(\$/hour)", style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(14))),
                                suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: ColorsApp.grayDBDBDB)),
                                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: ColorsApp.primary)),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(8)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // --- Nút Apply Filters ---
                    Padding(
                      padding: EdgeInsets.all(Responsive.rw(20)),
                      child: SizedBox(
                        width: double.infinity,
                        height: Responsive.rh(50),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // TODO: Áp dụng lọc
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsApp.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Responsive.rw(8))),
                            elevation: 0,
                          ),
                          child: Text(
                            "APPLY FILTERS",
                            style: TextStyle(
                              fontSize: Responsive.rw(14),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.rh(10)), // Safe area đáy
                  ],
                ),
              );
            }
        );
      },
    );
  }

  // ==========================================
  // WIDGET HỖ TRỢ XÂY DỰNG ITEM
  // ==========================================
  Widget _buildSectionHeaderWithSeeMore(String title) {
    return Padding(
      padding: EdgeInsets.only(left: Responsive.rw(20), right: Responsive.rw(20), bottom: Responsive.rh(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: Responsive.rw(20), fontWeight: FontWeight.bold, color: ColorsApp.textDark),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "SEE MORE",
              style: TextStyle(fontSize: Responsive.rw(12), fontWeight: FontWeight.w600, color: ColorsApp.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestGuideCard({required String image, required String name, required String location, required String reviews}) {
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
                child: Image.network(image, height: width, width: width, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  height: Responsive.rh(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(Responsive.rw(12))),
                    gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.7), Colors.transparent]),
                  ),
                ),
              ),
              Positioned(
                bottom: Responsive.rh(10), left: Responsive.rw(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: List.generate(5, (index) => Icon(Icons.star, color: ColorsApp.warning, size: Responsive.rw(12)))),
                    SizedBox(height: Responsive.rh(4)),
                    Text("$reviews Reviews", style: TextStyle(color: Colors.white, fontSize: Responsive.rw(10), fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.rh(8)),
          Text(name, style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
          SizedBox(height: Responsive.rh(4)),
          Row(
            children: [
              Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(12)),
              SizedBox(width: Responsive.rw(4)),
              Expanded(child: Text(location, style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12)), maxLines: 1, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedTourCard({required String image, required String title, required String date, required String days, required String price, required String likes, bool isFavorited = false}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: Responsive.rh(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.rw(12)),
        border: Border.all(color: ColorsApp.grayE8E8E8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
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
                    gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.7), Colors.transparent]),
                  ),
                ),
              ),
              Positioned(top: Responsive.rh(10), right: Responsive.rw(10), child: Icon(Icons.bookmark_border, color: Colors.white, size: Responsive.rw(20))),
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