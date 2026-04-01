import 'package:flutter/material.dart';
import 'package:demo/core/constants/colors_app.dart';
import 'package:demo/core/constants/responsive.dart';
import 'payment_summary_screen.dart';

class PaymentCheckoutScreen extends StatefulWidget {
  const PaymentCheckoutScreen({super.key});

  @override
  State<PaymentCheckoutScreen> createState() => _PaymentCheckoutScreenState();
}

class _PaymentCheckoutScreenState extends State<PaymentCheckoutScreen> {
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
          "Payment",
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
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Responsive.rw(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==========================================
                    // STEPPER (Trạng thái: Bước 1)
                    // ==========================================
                    _buildStepper(step2Active: false),
                    SizedBox(height: Responsive.rh(40)),

                    // ==========================================
                    // FORM NHẬP THẺ (Card Information)
                    // ==========================================
                    Row(
                      children: [
                        Icon(Icons.credit_card, color: ColorsApp.textDark, size: Responsive.rw(24)),
                        SizedBox(width: Responsive.rw(10)),
                        Text(
                          "Card Information",
                          style: TextStyle(
                            fontSize: Responsive.rw(20),
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.textDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.rh(30)),

                    _buildTextField("Card Holder's Name", "Card Holder's Name"),
                    SizedBox(height: Responsive.rh(25)),

                    _buildTextField("Card Number", "0000 0000 0000 0000"),
                    SizedBox(height: Responsive.rh(25)),

                    Row(
                      children: [
                        Expanded(child: _buildTextField("Expiration Date", "mm/yy")),
                        SizedBox(width: Responsive.rw(20)),
                        Expanded(child: _buildTextField("CVV", "000")),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ==========================================
            // NÚT NEXT (Chuyển sang bước Summary)
            // ==========================================
            Padding(
              padding: EdgeInsets.all(Responsive.rw(20)),
              child: SizedBox(
                width: double.infinity,
                height: Responsive.rh(50),
                child: ElevatedButton(
                  onPressed: () {
                    // Chuyển sang màn hình Tóm tắt
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaymentSummaryScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Responsive.rw(8)),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "NEXT",
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

  // Khối Stepper tái sử dụng
  Widget _buildStepper({required bool step2Active}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Chấm 1
            Container(
              width: Responsive.rw(16),
              height: Responsive.rw(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsApp.primary,
                border: Border.all(color: ColorsApp.primary.withOpacity(0.3), width: Responsive.rw(3)),
              ),
            ),
            // Đường line nét đứt nối giữa
            Expanded(
              child: Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: Responsive.rw(8)),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        (constraints.constrainWidth() / 6).floor(),
                            (index) => SizedBox(
                          width: 3,
                          height: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: step2Active ? ColorsApp.primary : ColorsApp.grayDBDBDB,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Chấm 2
            Container(
              width: Responsive.rw(16),
              height: Responsive.rw(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: step2Active ? ColorsApp.primary : ColorsApp.grayDBDBDB,
                border: Border.all(
                  color: step2Active ? ColorsApp.primary.withOpacity(0.3) : Colors.transparent,
                  width: Responsive.rw(3),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.rh(8)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment Method",
              style: TextStyle(
                color: ColorsApp.primary,
                fontSize: Responsive.rw(12),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Preview & Check out",
              style: TextStyle(
                color: step2Active ? ColorsApp.primary : ColorsApp.gray999,
                fontSize: Responsive.rw(12),
                fontWeight: step2Active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Khối Input trường nhập liệu
  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.rw(14),
            fontWeight: FontWeight.w600,
            color: ColorsApp.textDark,
          ),
        ),
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