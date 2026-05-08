import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, String>> faqs = const [
    {
      "q": "How to reset my password?",
      "a": "Go to settings → Account → Reset Password. You will get an OTP to reset it."
    },
    {
      "q": "How to contact support?",
      "a": "You can reach our support 24/7 using chat, email, or phone call."
    },
    {
      "q": "Is my data safe?",
      "a": "Yes. We follow high-level encryption and privacy policies to secure your data."
    },
    {
      "q": "How to delete my account?",
      "a": "Go to profile → Account → Delete Account. Follow the instructions carefully."
    },
  ];

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
          "FAQs",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                collapsedIconColor: Colors.white38,
                iconColor: const Color(0xFF7B5FFF),
                tilePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                title: Text(
                  faqs[index]["q"]!,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                    child: Text(
                      faqs[index]["a"]!,
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
