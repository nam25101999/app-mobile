import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'add_photos_screen.dart';

class MyPhotosScreen extends StatelessWidget {
  const MyPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    // Dữ liệu ảnh giả lập
    List<String> photos = [
      'https://images.unsplash.com/photo-1565670105658-9562470eb06b?q=80&w=400&fit=crop',
      'https://images.unsplash.com/photo-1476611317561-60117649dd94?q=80&w=400&fit=crop',
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?q=80&w=400&fit=crop',
      'https://images.unsplash.com/photo-1540202404-b71114228965?q=80&w=400&fit=crop',
      'https://images.unsplash.com/photo-1565670105658-9562470eb06b?q=80&w=400&fit=crop',
      'https://images.unsplash.com/photo-1476611317561-60117649dd94?q=80&w=400&fit=crop',
    ];

    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: AppBar(
        backgroundColor: ColorsApp.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsApp.textDark, size: Responsive.rw(20)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("My Photos", style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(18), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2, // Khoảng cách nhỏ giữa các ảnh
          mainAxisSpacing: 2,
        ),
        itemCount: photos.length + 1, // +1 cho nút Add Photo
        itemBuilder: (context, index) {
          if (index == 0) {
            // Nút Thêm ảnh
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPhotosScreen()));
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: ColorsApp.primary, width: 2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: ColorsApp.primary, size: Responsive.rw(30)),
                    SizedBox(height: Responsive.rh(4)),
                    Text("Add Photos", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12), fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            );
          }
          // Hình ảnh bình thường
          return Image.network(photos[index - 1], fit: BoxFit.cover);
        },
      ),
    );
  }
}