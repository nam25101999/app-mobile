import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
        title: Text("Change Password", style: TextStyle(color: ColorsApp.textDark, fontSize: Responsive.rw(18), fontWeight: FontWeight.bold)),
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
            SizedBox(height: Responsive.rh(20)),
            _buildTextField("Current Password", "••••••"),
            SizedBox(height: Responsive.rh(30)),
            _buildTextField("New Password", "••••••"),
            SizedBox(height: Responsive.rh(30)),
            _buildTextField("Retype New Password", "••••••"),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: Responsive.rw(14), fontWeight: FontWeight.w600, color: ColorsApp.textDark)),
        TextField(
          controller: TextEditingController(text: value),
          obscureText: true,
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