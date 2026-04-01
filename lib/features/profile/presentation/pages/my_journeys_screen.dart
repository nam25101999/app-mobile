import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'add_journey_screen.dart';

class MyJourneysScreen extends StatelessWidget {
  const MyJourneysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: AppBar(
        backgroundColor: ColorsApp.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsApp.textDark, size: Responsive.rw(20)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("My Journeys", style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(18), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.rw(20)),
        child: Column(
          children: [
            // Nút Add Journey
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddJourneyScreen()));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: Responsive.rh(12)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Responsive.rw(8)),
                  border: Border.all(color: ColorsApp.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: ColorsApp.primary, size: Responsive.rw(20)),
                    SizedBox(width: Responsive.rw(8)),
                    Text("Add Journey", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(14), fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            SizedBox(height: Responsive.rh(20)),

            // Danh sách Journeys
            _buildJourneyCard(
              title: "A memory in Danang",
              location: "Danang, Vietnam",
              date: "Jan 20, 2020",
              likes: "234",
              image1: 'https://images.unsplash.com/photo-1555126634-323283e090b0?q=80&w=400&fit=crop',
              image2: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=400&fit=crop',
              image3: 'https://images.unsplash.com/photo-1540202404-b71114228965?q=80&w=400&fit=crop',
            ),
            SizedBox(height: Responsive.rh(20)),
            _buildJourneyCard(
              title: "Sapa in spring",
              location: "Sapa, Vietnam",
              date: "Jan 20, 2020",
              likes: "234",
              image1: 'https://images.unsplash.com/photo-1559925393-8be0ca47e58c?q=80&w=400&fit=crop',
              image2: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=400&fit=crop',
              image3: 'https://images.unsplash.com/photo-1565670105658-9562470eb06b?q=80&w=400&fit=crop',
              moreCount: 6, // Thêm +6 cho ảnh cuối
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJourneyCard({required String title, required String location, required String date, required String likes, required String image1, required String image2, required String image3, int? moreCount}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.rw(12)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          SizedBox(
            height: Responsive.rh(160),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(Responsive.rw(12))),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Image.network(image1, fit: BoxFit.cover, height: double.infinity)),
                  SizedBox(width: Responsive.rw(2)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(child: Image.network(image2, fit: BoxFit.cover, width: double.infinity)),
                        SizedBox(height: Responsive.rh(2)),
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(image3, fit: BoxFit.cover),
                              if (moreCount != null)
                                Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: Center(child: Text("+$moreCount", style: TextStyle(color: Colors.white, fontSize: Responsive.rw(16), fontWeight: FontWeight.bold))),
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
          Padding(
            padding: EdgeInsets.all(Responsive.rw(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: Responsive.rw(16), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
                    Icon(Icons.more_horiz, color: ColorsApp.gray999),
                  ],
                ),
                SizedBox(height: Responsive.rh(8)),
                Row(
                  children: [
                    Icon(Icons.location_on, color: ColorsApp.primary, size: Responsive.rw(14)),
                    SizedBox(width: Responsive.rw(4)),
                    Text(location, style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12))),
                  ],
                ),
                SizedBox(height: Responsive.rh(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date, style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12))),
                    Row(
                      children: [
                        Icon(Icons.favorite_border, color: ColorsApp.primary, size: Responsive.rw(16)),
                        SizedBox(width: Responsive.rw(4)),
                        Text("$likes Likes", style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12))),
                      ],
                    ),
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