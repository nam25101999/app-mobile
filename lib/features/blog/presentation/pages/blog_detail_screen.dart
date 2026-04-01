import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';


class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({super.key});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. HEADER IMAGE & CLOSE BUTTON
            // ==========================================
            _buildHeaderImage(context),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==========================================
                  // 2. ACTION BAR (Like & Social Icons)
                  // ==========================================
                  _buildActionBar(),
                  SizedBox(height: Responsive.rh(10)),

                  // ==========================================
                  // 3. TITLE & AUTHOR
                  // ==========================================
                  Text(
                    "Title here: Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                    style: TextStyle(
                      fontSize: Responsive.rw(22),
                      fontWeight: FontWeight.bold,
                      color: ColorsApp.textDark,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: Responsive.rh(16)),
                  _buildAuthorInfo(),
                  SizedBox(height: Responsive.rh(20)),

                  // ==========================================
                  // 4. CONTENT PARAGRAPHS & MEDIA
                  // ==========================================
                  _buildContentText("Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                  SizedBox(height: Responsive.rh(16)),
                  _buildContentText("It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
                  SizedBox(height: Responsive.rh(20)),

                  // Video Thumbnail
                  _buildVideoThumbnail('https://images.unsplash.com/photo-1555921015-5532091f6026?q=80&w=800&fit=crop'),
                  SizedBox(height: Responsive.rh(20)),

                  // Subheading 1
                  _buildSubheading("Header here: Lorem Ipsum is simply dummy text of the printing and typesetting industry"),
                  SizedBox(height: Responsive.rh(16)),
                  _buildContentText("Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type."),
                  SizedBox(height: Responsive.rh(20)),

                  // Image Grid (2 cột)
                  _buildDoubleImage(
                    'https://images.unsplash.com/photo-1555126634-323283e090b0?q=80&w=400&fit=crop',
                    'https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?q=80&w=400&fit=crop',
                  ),
                  SizedBox(height: Responsive.rh(20)),

                  _buildContentText("Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type."),
                  SizedBox(height: Responsive.rh(16)),

                  // Hyperlink
                  _buildHyperlink("It was popularised in the 1960s with the release of Letraset sheets (Link)"),
                  SizedBox(height: Responsive.rh(20)),

                  // Single Large Image
                  _buildSingleImage('https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=800&fit=crop'),
                  SizedBox(height: Responsive.rh(20)),

                  // Subheading 2
                  _buildSubheading("Header here: Lorem Ipsum is simply dummy text of the printing and typesetting industry"),
                  SizedBox(height: Responsive.rh(16)),
                  _buildContentText("Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type."),
                  SizedBox(height: Responsive.rh(20)),

                  // Single Large Image 2
                  _buildSingleImage('https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=800&fit=crop'),
                  SizedBox(height: Responsive.rh(20)),

                  // ==========================================
                  // 5. TAGS & BOTTOM ACTION BAR
                  // ==========================================
                  _buildTags(),
                  SizedBox(height: Responsive.rh(20)),
                  _buildActionBar(),
                  SizedBox(height: Responsive.rh(20)),
                  const Divider(height: 1, color: ColorsApp.grayDBDBDB),
                  SizedBox(height: Responsive.rh(20)),

                  // ==========================================
                  // 6. COMMENTS SECTION
                  // ==========================================
                  _buildCommentsSection(),
                  SizedBox(height: Responsive.rh(40)),

                  // ==========================================
                  // 7. RELATED POSTS
                  // ==========================================
                  Text(
                    "Related Posts",
                    style: TextStyle(
                      fontSize: Responsive.rw(20),
                      fontWeight: FontWeight.bold,
                      color: ColorsApp.textDark,
                    ),
                  ),
                  SizedBox(height: Responsive.rh(20)),
                  _buildRelatedPosts(),
                  SizedBox(height: Responsive.rh(40)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // CÁC WIDGET HỖ TRỢ XÂY DỰNG GIAO DIỆN
  // ==========================================

  Widget _buildHeaderImage(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1565670105658-9562470eb06b?q=80&w=800&fit=crop', // Ảnh Hội An
          width: double.infinity,
          height: Responsive.rh(250),
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: IconButton(
            icon: Icon(Icons.close, color: ColorsApp.textDark, size: Responsive.rw(24)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _buildActionBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.rh(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.favorite_border, color: ColorsApp.primary, size: Responsive.rw(20)),
              SizedBox(width: Responsive.rw(8)),
              Text("Like 46", style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12))),
            ],
          ),
          Row(
            children: [
              Icon(Icons.facebook, color: ColorsApp.gray999, size: Responsive.rw(20)),
              SizedBox(width: Responsive.rw(16)),
              Icon(Icons.flutter_dash, color: ColorsApp.gray999, size: Responsive.rw(20)), // Dùng tạm icon chim cho Twitter
              SizedBox(width: Responsive.rw(16)),
              Icon(Icons.chat_bubble, color: ColorsApp.gray999, size: Responsive.rw(20)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: Responsive.rw(20),
          backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
        ),
        SizedBox(width: Responsive.rw(12)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Chin-Sun", style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
            SizedBox(height: Responsive.rh(4)),
            Row(
              children: [
                Icon(Icons.calendar_today, color: ColorsApp.gray999, size: Responsive.rw(12)),
                SizedBox(width: Responsive.rw(4)),
                Text("Mar 8, 2020", style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.gray999)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.textSecondary, height: 1.5),
    );
  }

  Widget _buildSubheading(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Responsive.rw(16),
        fontWeight: FontWeight.bold,
        color: ColorsApp.primary,
        height: 1.4,
      ),
    );
  }

  Widget _buildVideoThumbnail(String imageUrl) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Responsive.rw(8)),
          child: Image.network(imageUrl, width: double.infinity, height: Responsive.rh(200), fit: BoxFit.cover),
        ),
        Container(
          width: Responsive.rw(50),
          height: Responsive.rw(50),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.play_arrow, color: ColorsApp.primary, size: Responsive.rw(30)),
        ),
      ],
    );
  }

  Widget _buildDoubleImage(String img1, String img2) {
    return SizedBox(
      height: Responsive.rh(140),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.rw(8)),
              child: Image.network(img1, fit: BoxFit.cover, height: double.infinity),
            ),
          ),
          SizedBox(width: Responsive.rw(10)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.rw(8)),
              child: Image.network(img2, fit: BoxFit.cover, height: double.infinity),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Responsive.rw(8)),
      child: Image.network(imageUrl, width: double.infinity, height: Responsive.rh(200), fit: BoxFit.cover),
    );
  }

  Widget _buildHyperlink(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Responsive.rw(14),
        color: Colors.blue, // Màu xanh dương cho hyperlink
        height: 1.5,
      ),
    );
  }

  Widget _buildTags() {
    List<String> tags = ["#Vietnam Local Guide", "#Hoi An", "#Da Nang Local Tour", "#Vietnam", "#Guide"];
    return Wrap(
      spacing: Responsive.rw(10),
      runSpacing: Responsive.rh(10),
      children: tags.map((tag) => Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive.rw(12), vertical: Responsive.rh(6)),
        decoration: BoxDecoration(
          color: ColorsApp.grayF5F5F5,
          borderRadius: BorderRadius.circular(Responsive.rw(4)),
        ),
        child: Text(tag, style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(12))),
      )).toList(),
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Comments (1)", style: TextStyle(fontSize: Responsive.rw(18), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
            Icon(Icons.keyboard_arrow_up, color: ColorsApp.primary, size: Responsive.rw(24)),
          ],
        ),
        SizedBox(height: Responsive.rh(20)),

        // Comment Item
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Responsive.rw(40), height: Responsive.rw(40),
              decoration: const BoxDecoration(color: Color(0xFF5C9CFF), shape: BoxShape.circle), // Màu xanh dương nhạt
              child: Center(child: Text("CH", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Responsive.rw(14)))),
            ),
            SizedBox(width: Responsive.rw(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Chin-Hwa Lee", style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
                  SizedBox(height: Responsive.rh(4)),
                  Text("Mar 10, 2020", style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.gray999)),
                  SizedBox(height: Responsive.rh(8)),
                  Text(
                    "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.textSecondary, height: 1.5),
                  ),
                  SizedBox(height: Responsive.rh(12)),
                  // Reply button
                  Row(
                    children: [
                      Icon(Icons.chat_bubble_outline, color: ColorsApp.primary, size: Responsive.rw(16)),
                      SizedBox(width: Responsive.rw(6)),
                      Text("Reply", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(12), fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.rh(20)),

        // Add Comment Input Box
        Container(
          padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(12)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Responsive.rw(8)),
            border: Border.all(color: ColorsApp.grayE8E8E8),
          ),
          child: Row(
            children: [
              Container(
                width: Responsive.rw(30), height: Responsive.rw(30),
                decoration: const BoxDecoration(color: ColorsApp.primary, shape: BoxShape.circle),
                child: Icon(Icons.more_horiz, color: Colors.white, size: Responsive.rw(16)),
              ),
              SizedBox(width: Responsive.rw(12)),
              Text("Add Your Comment", style: TextStyle(color: ColorsApp.grayAFAFAF, fontSize: Responsive.rw(14))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedPosts() {
    return Column(
      children: [
        _buildTravelNewsCard(
          title: "New Destination in Danang City",
          date: "Feb 5, 2020",
          image: 'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?q=80&w=600&fit=crop',
        ),
        _buildTravelNewsCard(
          title: "\$1 Flight Ticket",
          date: "Feb 5, 2020",
          image: 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?q=80&w=600&fit=crop',
        ),
        _buildTravelNewsCard(
          title: "Visit Korea in this Tet Holiday",
          date: "Jan 26, 2020",
          image: 'https://images.unsplash.com/photo-1546874177-9e664107314e?q=80&w=600&fit=crop',
        ),
      ],
    );
  }

  Widget _buildTravelNewsCard({required String title, required String date, required String image}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.rh(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
          SizedBox(height: Responsive.rh(4)),
          Text(date, style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.gray999)),
          SizedBox(height: Responsive.rh(10)),
          ClipRRect(
            borderRadius: BorderRadius.circular(Responsive.rw(12)),
            child: Image.network(image, height: Responsive.rh(120), width: double.infinity, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}