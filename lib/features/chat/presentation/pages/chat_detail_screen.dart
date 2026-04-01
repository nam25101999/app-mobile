import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'add_friend_screen.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _msgController = TextEditingController();
  bool _isTyping = false;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _msgController.addListener(() {
      setState(() {
        _isTyping = _msgController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _msgController.dispose();
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
          icon: Icon(Icons.arrow_back_ios, color: ColorsApp.textDark, size: Responsive.rw(20)),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildAppBarAvatars(), // Cụm avatar chồng nhau
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: ColorsApp.primary, size: Responsive.rw(28)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddFriendScreen()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ==========================================
          // KHU VỰC HIỂN THỊ TIN NHẮN
          // ==========================================
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20), vertical: Responsive.rh(10)),
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Responsive.rw(12), vertical: Responsive.rh(6)),
                    decoration: BoxDecoration(color: ColorsApp.grayF5F5F5, borderRadius: BorderRadius.circular(Responsive.rw(16))),
                    child: Text("Jan 28, 2020", style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.gray777)),
                  ),
                ),
                SizedBox(height: Responsive.rh(20)),

                // Tin nhắn của người khác (Emmy)
                _buildOtherMessage(
                  avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
                  name: "Emmy",
                  time: "10:30 AM",
                  messages: [
                    "hi, this is Emmy",
                    "It is a long established fact that a reader will be distracted by the",
                  ],
                ),

                SizedBox(height: Responsive.rh(20)),
                // Tin nhắn của bản thân (căn phải)
                _buildMyMessage(
                  time: "10:31 AM",
                  messages: [
                    "as opposed to using 'Content here",
                    "There are many variations of passages",
                  ],
                ),

                SizedBox(height: Responsive.rh(20)),
                // Tin nhắn của người khác thứ 2 (Gil Hajoon)
                _buildOtherMessage(
                  avatar: 'https://randomuser.me/api/portraits/women/68.jpg',
                  name: "Gil Hajoon",
                  time: "10:30 AM",
                  messages: [
                    "It is a long established fact",
                  ],
                ),
              ],
            ),
          ),

          // ==========================================
          // BOTTOM INPUT AREA (Dynamic State)
          // ==========================================
          _buildBottomInputArea(),
        ],
      ),
    );
  }

  // Cụm 3 Avatar xếp chồng trên AppBar
  Widget _buildAppBarAvatars() {
    double radius = Responsive.rw(16);
    return SizedBox(
      width: radius * 4,
      height: radius * 2,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: CircleAvatar(radius: radius, backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/44.jpg')),
          ),
          Positioned(
            left: radius * 0.8,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
              child: CircleAvatar(radius: radius, backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/68.jpg')),
            ),
          ),
          Positioned(
            left: radius * 1.6,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
              child: CircleAvatar(radius: radius, backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/men/46.jpg')),
            ),
          ),
        ],
      ),
    );
  }

  // Tin nhắn của người khác (Bên trái, Xanh lá)
  Widget _buildOtherMessage({required String avatar, required String name, required String time, required List<String> messages}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: Responsive.rw(20), backgroundImage: NetworkImage(avatar)),
        SizedBox(width: Responsive.rw(10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.bold, color: ColorsApp.textDark)),
                  SizedBox(width: Responsive.rw(8)),
                  Text(time, style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.gray999)),
                ],
              ),
              SizedBox(height: Responsive.rh(4)),
              ...messages.map((msg) => Padding(
                padding: EdgeInsets.only(top: Responsive.rh(4)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(12)),
                  decoration: BoxDecoration(
                    color: ColorsApp.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Responsive.rw(16)),
                      topRight: Radius.circular(Responsive.rw(16)),
                      bottomRight: Radius.circular(Responsive.rw(16)),
                      bottomLeft: const Radius.circular(0), // Nhọn góc dưới trái
                    ),
                  ),
                  child: Text(msg, style: TextStyle(color: Colors.white, fontSize: Responsive.rw(14), height: 1.4)),
                ),
              )).toList(),
            ],
          ),
        ),
        SizedBox(width: Responsive.rw(40)), // Chừa lề phải
      ],
    );
  }

  // Tin nhắn của tôi (Bên phải, Xám nhạt)
  Widget _buildMyMessage({required String time, required List<String> messages}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(time, style: TextStyle(fontSize: Responsive.rw(12), color: ColorsApp.gray999)),
        SizedBox(height: Responsive.rh(4)),
        ...messages.map((msg) => Padding(
          padding: EdgeInsets.only(top: Responsive.rh(4)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(12)),
            decoration: BoxDecoration(
              color: ColorsApp.grayF5F5F5,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Responsive.rw(16)),
                topRight: Radius.circular(Responsive.rw(16)),
                bottomLeft: Radius.circular(Responsive.rw(16)),
                bottomRight: const Radius.circular(0), // Nhọn góc dưới phải
              ),
            ),
            child: Text(msg, style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(14), height: 1.4)),
          ),
        )).toList(),
      ],
    );
  }

  // Khu vực nhập liệu ở đáy (Xử lý 3 state)
  Widget _buildBottomInputArea() {
    return Container(
      padding: EdgeInsets.only(
          left: Responsive.rw(20), right: Responsive.rw(20),
          top: Responsive.rh(10), bottom: Responsive.rh(25) // SafeArea padding
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: _isRecording
          ? _buildRecordingState() // STATE 3: Đang ghi âm
          : Row(
        children: [
          // Icon Mic (Nhấn giữ để thu âm)
          GestureDetector(
            onLongPress: () => setState(() => _isRecording = true),
            child: Icon(Icons.mic_none, color: ColorsApp.gray777, size: Responsive.rw(28)),
          ),
          SizedBox(width: Responsive.rw(15)),
          // Icon Image
          Icon(Icons.image_outlined, color: ColorsApp.gray777, size: Responsive.rw(28)),
          SizedBox(width: Responsive.rw(15)),

          // Ô nhập Text
          Expanded(
            child: Container(
              height: Responsive.rh(40),
              decoration: BoxDecoration(color: ColorsApp.grayF5F5F5, borderRadius: BorderRadius.circular(Responsive.rw(20))),
              child: TextField(
                controller: _msgController,
                decoration: InputDecoration(
                  hintText: "Type message",
                  hintStyle: TextStyle(color: ColorsApp.grayAFAFAF, fontSize: Responsive.rw(14)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: Responsive.rw(16), vertical: Responsive.rh(10)),
                ),
              ),
            ),
          ),

          // Nút Gửi máy bay (Chỉ hiện khi có gõ Text - STATE 2)
          if (_isTyping) ...[
            SizedBox(width: Responsive.rw(15)),
            GestureDetector(
              onTap: () {
                _msgController.clear();
                FocusScope.of(context).unfocus(); // Tắt bàn phím
              },
              child: Container(
                width: Responsive.rw(40), height: Responsive.rw(40),
                decoration: const BoxDecoration(color: ColorsApp.primary, shape: BoxShape.circle),
                child: Icon(Icons.send, color: Colors.white, size: Responsive.rw(20)),
              ),
            ),
          ]
        ],
      ),
    );
  }

  // STATE 3: UI khi đang ghi âm Voice (Giống thiết kế Chat-Voice Message.svg)
  Widget _buildRecordingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("0:12", style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(14))),
        SizedBox(height: Responsive.rh(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Nút Hủy
            IconButton(
              icon: Icon(Icons.close, color: ColorsApp.textDark, size: Responsive.rw(28)),
              onPressed: () => setState(() => _isRecording = false),
            ),
            // Nút Mic to ở giữa (Có gợn sóng)
            Container(
              width: Responsive.rw(60), height: Responsive.rw(60),
              decoration: BoxDecoration(
                color: ColorsApp.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: ColorsApp.primary.withOpacity(0.2), spreadRadius: Responsive.rw(10))],
              ),
              child: Icon(Icons.mic_none, color: ColorsApp.primary, size: Responsive.rw(30)),
            ),
            // Nút Gửi máy bay
            GestureDetector(
              onTap: () => setState(() => _isRecording = false),
              child: Container(
                width: Responsive.rw(40), height: Responsive.rw(40),
                decoration: const BoxDecoration(color: ColorsApp.primary, shape: BoxShape.circle),
                child: Icon(Icons.send, color: Colors.white, size: Responsive.rw(20)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}