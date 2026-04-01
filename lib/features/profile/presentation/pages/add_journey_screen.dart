import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class AddJourneyScreen extends StatelessWidget {
  const AddJourneyScreen({super.key});

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
        title: Text("Add Journey", style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(18), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("DONE", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(14), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Responsive.rw(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Name", "Journey's Name"),
            SizedBox(height: Responsive.rh(25)),
            _buildTextField("Location", "Location of Journey"),
            SizedBox(height: Responsive.rh(30)),

            // Nút Upload Photos (Viền nét đứt mô phỏng)
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: Responsive.rh(15)),
                // Sử dụng viền liền mảnh mô phỏng nét đứt để không phải cài thêm package
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Responsive.rw(8)),
                  border: Border.all(color: ColorsApp.primary.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: ColorsApp.primary, size: Responsive.rw(20)),
                    SizedBox(width: Responsive.rw(8)),
                    Text("Upload Photos", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(14), fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.w600, color: ColorsApp.textDark)),
        TextField(
          style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.textDark),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: ColorsApp.grayAFAFAF, fontSize: Responsive.rw(14)),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: Responsive.rh(10)),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: ColorsApp.grayDBDBDB)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: ColorsApp.primary, width: 2)),
          ),
        ),
      ],
    );
  }
}