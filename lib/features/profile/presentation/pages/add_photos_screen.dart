import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({super.key});

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  // Trạng thái chọn ảnh giả lập
  List<bool> _selectedPhotos = List.generate(8, (index) => index == 2 || index == 5); // Mockup đang chọn ảnh 3 và 6

  List<String> photos = [
    'https://images.unsplash.com/photo-1565670105658-9562470eb06b?q=80&w=400&fit=crop',
    'https://images.unsplash.com/photo-1476611317561-60117649dd94?q=80&w=400&fit=crop',
    'https://images.unsplash.com/photo-1540202404-b71114228965?q=80&w=400&fit=crop',
    'https://images.unsplash.com/photo-1555126634-323283e090b0?q=80&w=400&fit=crop',
    'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=400&fit=crop',
    'https://images.unsplash.com/photo-1476611317561-60117649dd94?q=80&w=400&fit=crop',
  ];

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
        title: Text("Add Photos", style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(18), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("DONE", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(14), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: photos.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Nút Take Photo
            return Container(
              decoration: BoxDecoration(border: Border.all(color: ColorsApp.primary, width: 2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: ColorsApp.primary, size: Responsive.rw(30)),
                  SizedBox(height: Responsive.rh(4)),
                  Text("Take Photo", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12), fontWeight: FontWeight.w500)),
                ],
              ),
            );
          }

          int photoIndex = index - 1;
          bool isSelected = _selectedPhotos[photoIndex];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedPhotos[photoIndex] = !_selectedPhotos[photoIndex];
              });
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(photos[photoIndex], fit: BoxFit.cover),
                // Vòng tròn chọn
                Positioned(
                  top: Responsive.rh(8), right: Responsive.rw(8),
                  child: Container(
                    width: Responsive.rw(24), height: Responsive.rw(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? ColorsApp.primary : Colors.transparent,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: isSelected ? Icon(Icons.check, color: Colors.white, size: Responsive.rw(16)) : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}