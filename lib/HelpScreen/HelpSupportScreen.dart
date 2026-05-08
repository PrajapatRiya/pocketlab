import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import ' TermsScreen/TermsConditionsScreen.dart';
import 'FAQsScreen/FAQScreen.dart';
import 'PrivacyPolicyScreen/PrivacyPolicyScreen.dart';
import 'chatboatscreen/ContactFormScreen.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        title: Text(
          "Help & Support",
          style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER CARD
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B5FFF), Color(0xFF4A00E0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7B5FFF).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How can we help you?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Our support team is available 24/7 to assist you with any queries.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14.sp,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            Text(
              "Support Options",
              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),

            _buildHelpCard(
              title: "FAQs",
              subtitle: "Quick answers to common questions",
              icon: Icons.help_outline_rounded,
              color: Colors.orangeAccent,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FAQScreen())),
            ),
            _buildHelpCard(
              title: "Contact Us",
              subtitle: "Get instant support via chat",
              icon: Icons.chat_bubble_outline_rounded,
              color: Colors.lightBlueAccent,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactFormScreen())),
            ),
            _buildHelpCard(
              title: "Terms & Conditions",
              subtitle: "Read our user agreement",
              icon: Icons.gavel_rounded,
              color: Colors.greenAccent,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsConditionsScreen())),
            ),
            _buildHelpCard(
              title: "Privacy Policy",
              subtitle: "How we protect your data",
              icon: Icons.privacy_tip_outlined,
              color: Colors.redAccent,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen())),
            ),

            SizedBox(height: 40.h),

            Center(
              child: Column(
                children: [
                  Text(
                    "Pocket Lab Support",
                    style: TextStyle(color: Colors.white38, fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Version 1.0.0",
                    style: TextStyle(color: Colors.white24, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, size: 24.sp, color: color),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: Colors.white24),
            ],
          ),
        ),
      ),
    );
  }
}
