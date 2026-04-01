import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

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
        title: Text("Settings", style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(18), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thẻ thông tin User (Màu xanh)
          Container(
            margin: EdgeInsets.all(Responsive.rw(20)),
            padding: EdgeInsets.all(Responsive.rw(20)),
            decoration: BoxDecoration(
              color: ColorsApp.primary,
              borderRadius: BorderRadius.circular(Responsive.rw(12)),
            ),
            child: Row(
              children: [
                CircleAvatar(radius: Responsive.rw(30), backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/44.jpg')),
                SizedBox(width: Responsive.rw(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Yoo Jin", style: TextStyle(color: Colors.white, fontSize: Responsive.rw(18), fontWeight: FontWeight.bold)),
                      SizedBox(height: Responsive.rh(4)),
                      Text("Traveler", style: TextStyle(color: Colors.white, fontSize: Responsive.rw(14))),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Responsive.rw(4))),
                  ),
                  child: Text("EDIT PROFILE", style: TextStyle(color: Colors.white, fontSize: Responsive.rw(10), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          // Danh sách menu
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: Responsive.rw(20)),
              children: [
                _buildMenuItem(Icons.notifications_none, "Notifications", trailing: Switch(
                  value: _notificationsEnabled,
                  activeColor: ColorsApp.primary,
                  onChanged: (val) => setState(() => _notificationsEnabled = val),
                )),
                _buildMenuItem(Icons.public, "Languages", trailing: Icon(Icons.arrow_forward_ios, color: ColorsApp.gray999, size: Responsive.rw(14))),
                _buildMenuItem(Icons.payment, "Payment", trailing: Icon(Icons.arrow_forward_ios, color: ColorsApp.gray999, size: Responsive.rw(14))),
                _buildMenuItem(Icons.security, "Privacy & Policies", trailing: Icon(Icons.arrow_forward_ios, color: ColorsApp.gray999, size: Responsive.rw(14))),
                _buildMenuItem(Icons.mail_outline, "Feedback", trailing: Icon(Icons.arrow_forward_ios, color: ColorsApp.gray999, size: Responsive.rw(14))),
                _buildMenuItem(Icons.menu_book, "Usage", trailing: Icon(Icons.arrow_forward_ios, color: ColorsApp.gray999, size: Responsive.rw(14))),

                SizedBox(height: Responsive.rh(30)),
                // Nút Sign out
                Padding(
                  padding: EdgeInsets.only(left: Responsive.rw(40)), // Canh lề chữ theo icon
                  child: GestureDetector(
                    onTap: () {},
                    child: Text("Sign out", style: TextStyle(color: ColorsApp.gray999, fontSize: Responsive.rw(14))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {required Widget trailing}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ColorsApp.grayDBDBDB)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: ColorsApp.textDark, size: Responsive.rw(20)),
        title: Text(title, style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(16))),
        trailing: trailing,
      ),
    );
  }
}