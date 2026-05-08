import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
        ),
        title: Text(
          "Privacy Policy",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Effective Date: 1 December 2025",
                style: TextStyle(
                  color: const Color(0xFF7B5FFF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              _policyText(
                "Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our app.\n\n"
                "1. Information Collection:\n"
                "We may collect personal information such as name, email address, and usage data to improve our services.\n\n"
                "2. Use of Information:\n"
                "The information collected is used to provide, maintain, and improve our app services, and communicate with you regarding updates or offers.\n\n"
                "3. Data Protection:\n"
                "We take appropriate measures to protect your data from unauthorized access, alteration, disclosure, or destruction.\n\n"
                "4. Third-Party Services:\n"
                "We do not share your personal information with third parties without your consent, except as required by law.\n\n"
                "5. Changes to Privacy Policy:\n"
                "We may update this Privacy Policy from time to time. Changes will be reflected on this page.\n\n"
                "6. Contact Us:\n"
                "If you have any questions regarding this Privacy Policy, please contact us at support@pocketlab.com."
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _policyText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        height: 1.6,
        color: Colors.white70,
      ),
    );
  }
}
