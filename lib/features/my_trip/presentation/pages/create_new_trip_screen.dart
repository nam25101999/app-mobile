import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class CreateNewTripScreen extends StatefulWidget {
  const CreateNewTripScreen({super.key});

  @override
  State<CreateNewTripScreen> createState() => _CreateNewTripScreenState();
}

class _CreateNewTripScreenState extends State<CreateNewTripScreen> {
  int _travelersCount = 1;

  // Controllers để hiển thị text giống như bản thiết kế
  final TextEditingController _locationController = TextEditingController(text: "Danang, Vietnam");
  final TextEditingController _languageController = TextEditingController(text: "Korean, English");

  @override
  void dispose() {
    _locationController.dispose();
    _languageController.dispose();
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
        title: Text(
          "Create New Trip",
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
            // ==========================================
            // NỘI DUNG FORM (Cuộn được)
            // ==========================================
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Where you want to explore ---
                    _buildLabel("Where you want to explore"),
                    _buildTextField(
                      hintText: "Location",
                      icon: Icons.location_on_outlined,
                      controller: _locationController,
                    ),
                    SizedBox(height: Responsive.rh(25)),

                    // --- Date ---
                    _buildLabel("Date"),
                    _buildTextField(
                      hintText: "mm/dd/yy",
                      icon: Icons.calendar_today_outlined,
                    ),
                    SizedBox(height: Responsive.rh(25)),

                    // --- Time (From - To) ---
                    _buildLabel("Time"),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            hintText: "From",
                            icon: Icons.access_time,
                          ),
                        ),
                        SizedBox(width: Responsive.rw(20)),
                        Expanded(
                          child: _buildTextField(
                            hintText: "To",
                            icon: Icons.access_time,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.rh(25)),

                    // --- Number of travelers ---
                    _buildLabel("Number of travelers"),
                    SizedBox(height: Responsive.rh(10)),
                    Row(
                      children: [
                        // Nút giảm
                        _buildCounterButton(
                          icon: Icons.arrow_drop_down,
                          onTap: () {
                            if (_travelersCount > 1) {
                              setState(() => _travelersCount--);
                            }
                          },
                        ),
                        // Số lượng
                        Container(
                          width: Responsive.rw(80),
                          margin: EdgeInsets.symmetric(horizontal: Responsive.rw(15)),
                          padding: EdgeInsets.symmetric(vertical: Responsive.rh(8)),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: ColorsApp.grayDBDBDB),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "$_travelersCount",
                            style: TextStyle(
                              fontSize: Responsive.rw(16),
                              color: ColorsApp.textDark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Nút tăng
                        _buildCounterButton(
                          icon: Icons.arrow_drop_up,
                          onTap: () {
                            setState(() => _travelersCount++);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.rh(25)),

                    // --- Fee ---
                    _buildLabel("Fee"),
                    _buildTextField(
                      hintText: "Fee",
                      icon: Icons.monetization_on_outlined,
                      suffixText: "(\$/hour)",
                    ),
                    SizedBox(height: Responsive.rh(25)),

                    // --- Guide's Language ---
                    _buildLabel("Guide's Language"),
                    _buildTextField(
                      hintText: "Language",
                      icon: Icons.public,
                      controller: _languageController,
                    ),
                    SizedBox(height: Responsive.rh(30)),

                    // --- Attractions ---
                    _buildLabel("Attractions"),
                    SizedBox(height: Responsive.rh(15)),
                    Wrap(
                      spacing: Responsive.rw(15),
                      runSpacing: Responsive.rh(15),
                      children: [
                        _buildAddNewCard(),
                        _buildAttractionCard(
                          image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=400&fit=crop',
                          title: "Dragon Bridge",
                          isSelected: true,
                        ),
                        _buildAttractionCard(
                          image: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=400&fit=crop',
                          title: "Cham Museum",
                          isSelected: false,
                        ),
                        _buildAttractionCard(
                          image: 'https://images.unsplash.com/photo-1576487248805-4c6e5ce6165e?q=80&w=400&fit=crop',
                          title: "My Khe Beach",
                          isSelected: true,
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.rh(40)), // Khoảng trống cuối trang
                  ],
                ),
              ),
            ),

            // ==========================================
            // NÚT DONE (Cố định ở dưới cùng)
            // ==========================================
            Padding(
              padding: EdgeInsets.all(Responsive.rw(20)),
              child: SizedBox(
                width: double.infinity,
                height: Responsive.rh(50),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Xử lý hành động DONE
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Responsive.rw(8)),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "DONE",
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

  // ==========================================
  // CÁC WIDGET HỖ TRỢ
  // ==========================================

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Responsive.rw(14),
        fontWeight: FontWeight.w600,
        color: ColorsApp.textDark,
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    TextEditingController? controller,
    String? suffixText,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(
        fontSize: Responsive.rw(14),
        color: ColorsApp.textDark,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorsApp.grayAFAFAF,
          fontSize: Responsive.rw(14),
        ),
        prefixIcon: Icon(
          icon,
          color: ColorsApp.gray999,
          size: Responsive.rw(18),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: Responsive.rw(30),
        ),
        suffixIcon: suffixText != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              suffixText,
              style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(14)),
            ),
          ],
        )
            : null,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(8)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.grayDBDBDB),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildCounterButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Responsive.rw(40),
        height: Responsive.rh(32),
        decoration: BoxDecoration(
          color: ColorsApp.grayF5F5F5,
          borderRadius: BorderRadius.circular(Responsive.rw(4)),
        ),
        child: Icon(
          icon,
          color: ColorsApp.primary,
          size: Responsive.rw(24),
        ),
      ),
    );
  }

  Widget _buildAddNewCard() {
    final width = (Responsive.screenWidth - Responsive.rw(40) - Responsive.rw(15)) / 2;
    return Container(
      width: width,
      height: Responsive.rh(90),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.rw(8)),
        border: Border.all(color: ColorsApp.grayE8E8E8, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: ColorsApp.primary, size: Responsive.rw(24)),
          SizedBox(height: Responsive.rh(4)),
          Text(
            "Add New",
            style: TextStyle(
              color: ColorsApp.primary,
              fontSize: Responsive.rw(14),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttractionCard({required String image, required String title, required bool isSelected}) {
    final width = (Responsive.screenWidth - Responsive.rw(40) - Responsive.rw(15)) / 2;
    return Container(
      width: width,
      height: Responsive.rh(90),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.rw(8)),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
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
          Positioned(
            top: Responsive.rh(8),
            right: Responsive.rw(8),
            child: Container(
              width: Responsive.rw(20),
              height: Responsive.rw(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? ColorsApp.primary : Colors.black.withOpacity(0.2),
                border: isSelected ? null : Border.all(color: Colors.white.withOpacity(0.5)),
              ),
              child: Icon(
                Icons.check,
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                size: Responsive.rw(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}