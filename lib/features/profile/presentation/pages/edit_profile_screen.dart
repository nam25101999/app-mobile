import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'change_password_screen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
        title: Text("Edit Profile", style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(18), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("SAVE", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(14), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.rw(20)),
        child: Column(
          children: [
            // Avatar Editor
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: Responsive.rw(50),
                    backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
                  ),
                  Positioned(
                    top: 0, right: 0,
                    child: Container(
                      padding: EdgeInsets.all(Responsive.rw(6)),
                      decoration: const BoxDecoration(color: ColorsApp.white, shape: BoxShape.circle),
                      child: Icon(Icons.camera_alt, color: ColorsApp.primary, size: Responsive.rw(16)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.rh(40)),

            // Form
            Row(
              children: [
                Expanded(child: _buildTextField("First Name", "Yoo")),
                SizedBox(width: Responsive.rw(20)),
                Expanded(child: _buildTextField("Last Name", "Jin")),
              ],
            ),
            SizedBox(height: Responsive.rh(30)),

            _buildTextField("Password", "••••••", obscureText: true),
            SizedBox(height: Responsive.rh(20)),

            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                },
                child: Text("Change Password", style: TextStyle(color: ColorsApp.primary, fontSize: Responsive.rw(14), fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.w600, color: ColorsApp.textDark)),
        TextField(
          controller: TextEditingController(text: value),
          obscureText: obscureText,
          style: TextStyle(fontSize: Responsive.rw(14), color: ColorsApp.textDark),
          decoration: InputDecoration(
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