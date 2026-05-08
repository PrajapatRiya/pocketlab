import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background Glow Effects (Same as Dashboard)
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlurCircle(theme.colorScheme.primary.withOpacity(0.12), 250),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: _buildBlurCircle(theme.colorScheme.secondary.withOpacity(0.08), 200),
          ),
          
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "Upgrade to Premium",
                          style: TextStyle(color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Choose the plan that fits your learning goals and unlock all professional features.",
                          style: TextStyle(color: Colors.white54, fontSize: 14.sp, height: 1.5, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 35.h),
                        
                        _buildPlanCard(
                          title: "Basic Plan",
                          price: "₹199",
                          period: "/ month",
                          color: theme.colorScheme.surface,
                          accentColor: Colors.blueAccent,
                          benefits: ["Access to basic courses", "PDF study materials", "Basic certificate"],
                        ),
                        SizedBox(height: 20.h),
                        
                        _buildPlanCard(
                          title: "Standard Plan",
                          price: "₹399",
                          period: "/ month",
                          isPopular: true,
                          color: theme.colorScheme.surface,
                          accentColor: theme.colorScheme.primary,
                          benefits: ["All basic features", "Live doubt classes", "Completion certificate", "Offline downloads"],
                        ),
                        SizedBox(height: 20.h),
                        
                        _buildPlanCard(
                          title: "Premium Plan",
                          price: "₹699",
                          period: "/ month",
                          color: theme.colorScheme.surface,
                          accentColor: Colors.amber,
                          benefits: ["All standard features", "1-on-1 mentorship", "Premium certificate", "Priority support"],
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
          Text(
            "Subscription Plans",
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String period,
    required Color color,
    required Color accentColor,
    required List<String> benefits,
    bool isPopular = false,
  }) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: isPopular ? accentColor.withOpacity(0.5) : Colors.white.withOpacity(0.05), width: isPopular ? 2 : 1),
        boxShadow: isPopular ? [
          BoxShadow(color: accentColor.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))
        ] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w900)),
              if (isPopular)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(10.r)),
                  child: Text("POPULAR", style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w900, letterSpacing: 1)),
                ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: TextStyle(color: Colors.white, fontSize: 36.sp, fontWeight: FontWeight.w900, letterSpacing: -1)),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h, left: 6.w),
                child: Text(period, style: TextStyle(color: Colors.white38, fontSize: 14.sp, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          Divider(color: Colors.white.withOpacity(0.05), thickness: 1),
          SizedBox(height: 25.h),
          ...benefits.map((b) => Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(color: accentColor.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(Icons.check_rounded, color: accentColor, size: 14.sp),
                ),
                SizedBox(width: 15.w),
                Text(b, style: TextStyle(color: Colors.white70, fontSize: 14.sp, fontWeight: FontWeight.w600)),
              ],
            ),
          )),
          SizedBox(height: 25.h),
          SizedBox(
            width: double.infinity,
            height: 54.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isPopular ? accentColor : Colors.white.withOpacity(0.05),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              ),
              child: Text(
                "Select Plan",
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
