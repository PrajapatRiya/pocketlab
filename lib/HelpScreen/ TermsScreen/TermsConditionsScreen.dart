import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  final String termsText = """
1. Acceptance of Terms
By using this app, you agree to these terms and conditions.

2. User Responsibilities
You are responsible for maintaining the confidentiality of your account and for all activities under your account.

3. Privacy Policy
Your privacy is important to us. We collect and use your data according to our Privacy Policy.

4. Limitation of Liability
We are not responsible for any damages arising from the use of this app.

5. Modifications
We may update these terms at any time. Continued use of the app constitutes acceptance of new terms.

6. Governing Law
These terms are governed by the laws applicable in your region.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Terms & Conditions",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Text(
            termsText,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
              height: 1.6,
            ),
          ),
        ),
      ),
    );
  }
}
