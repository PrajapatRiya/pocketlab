import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pocketlab/coursedetailscreen/coursedetailsscreen.dart';
import 'package:pocketlab/videoplayerscreen/videoplayerscreen.dart';
import '../CertificateScreen/CompletionCertificateScreen.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  String selectedCategory = "All";

  final List<Map<String, dynamic>> courses = [
    {
      "title": "The Complete Python Bootcamp",
      "author": "By Dr. Angela Yu",
      "rating": "4.7",
      "reviews": "(32k)",
      "level": "Beginner",
      "image": "assets/images/python.jpeg",
      "progress": 0.45,
    },
    {
      "title": "UX Design Process from A-Z",
      "author": "By Jane Smith",
      "rating": "4.9",
      "reviews": "(12k)",
      "level": "Intermediate",
      "image": "assets/images/logo-design.png",
      "progress": 0.85,
    },
    {
      "title": "Digital Marketing Masterclass",
      "author": "By Jonathan Doe",
      "rating": "4.6",
      "reviews": "(20k)",
      "level": "All Levels",
      "image": "assets/images/marketing.png",
      "progress": 0.25,
    },
    {
      "title": "React - The Complete Guide",
      "author": "By Maximilian Schwarzmüller",
      "rating": "4.8",
      "reviews": "(15k)",
      "level": "Advanced",
      "image": "assets/images/react.png",
      "progress": 0.60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCourses = selectedCategory == "All"
        ? courses
        : courses.where((course) {
      if (selectedCategory == "Development") {
        return course["title"].toString().contains("Python") ||
            course["title"].toString().contains("React");
      } else if (selectedCategory == "Design") {
        return course["title"].toString().contains("Design");
      } else if (selectedCategory == "Business") {
        return course["title"].toString().contains("Marketing");
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background Glow Effects
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlurCircle(Theme.of(context).colorScheme.primary.withOpacity(0.1), 250),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: _buildBlurCircle(Theme.of(context).colorScheme.secondary.withOpacity(0.08), 200),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                SizedBox(height: 20.h),

                /// ---------------------- Search Bar ----------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      decoration: InputDecoration(
                        hintText: "Search your courses...",
                        hintStyle: TextStyle(color: Colors.white30, fontSize: 14.sp),
                        prefixIcon: Icon(Icons.search_rounded, color: Theme.of(context).colorScheme.primary, size: 22.sp),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25.h),

                /// ---------------------- Category Tabs ----------------------
                SizedBox(
                  height: 42.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _categoryChip("All"),
                      _categoryChip("Development"),
                      _categoryChip("Design"),
                      _categoryChip("Business"),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),

                /// ---------------------- COURSE LIST ----------------------
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 100.h),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = filteredCourses[index];
                      return _buildCourseCard(course);
                    },
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
          ),
          Text(
            "My Learning",
            style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: -0.5),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoPlayerScreen()));
            },
            icon: Icon(Icons.play_circle_fill_rounded, color: Theme.of(context).colorScheme.primary, size: 28.sp),
          ),
        ],
      ),
    );
  }

  Widget _categoryChip(String text) {
    bool isSelected = selectedCategory == text;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = text),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.05)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white60,
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseDetailPage()));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: Image.asset(course["image"], height: 60.w, width: 60.w, fit: BoxFit.cover),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course["title"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 4.h),
                  Text(course["author"], style: TextStyle(color: Colors.white54, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                  SizedBox(height: 12.h),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Progress", style: TextStyle(color: Colors.white30, fontSize: 11.sp, fontWeight: FontWeight.bold)),
                          Text("${(course["progress"] * 100).toInt()}%",
                              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12.sp, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        lineHeight: 6.h,
                        percent: course["progress"],
                        animation: true,
                        barRadius: Radius.circular(10.r),
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        progressColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
