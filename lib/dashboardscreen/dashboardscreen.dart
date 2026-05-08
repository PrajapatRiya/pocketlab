import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketlab/HelpScreen/HelpSupportScreen.dart';
import 'package:pocketlab/NotificationScreen/Noticationscreen.dart';

class DashboardBlueScreen extends StatefulWidget {
  const DashboardBlueScreen({super.key});

  @override
  State<DashboardBlueScreen> createState() => _DashboardBlueScreenState();
}

class _DashboardBlueScreenState extends State<DashboardBlueScreen> {
  bool isLoggedIn = true;

  final List<Map<String, String>> _recommendedCourses = [
    {
      'title': 'Flutter Development',
      'subtitle': 'Build beautiful apps',
      'image': 'assets/images/flutter7.jpg',
    },
    {
      'title': 'Python for Beginners',
      'subtitle': 'Start coding today',
      'image': 'assets/images/python1.jpg',
    },
    {
      'title': 'UI/UX Design Mastery',
      'subtitle': 'Learn modern design',
      'image': 'assets/images/ux.jpg',
    },
  ];

  final List<Map<String, dynamic>> _continueCourses = [
    {
      'title': 'React Native Mobile Development',
      'lesson': 'Lesson 12: Navigation Patterns',
      'progress': 0.65,
      'image': 'assets/images/react1.png',
    },
    {
      'title': 'Cybersecurity Fundamentals',
      'lesson': 'Lesson 6: Network Security',
      'progress': 0.32,
      'image': 'assets/images/cyber1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background Decorative Bubbles (Professional Glow)
          Positioned(
            top: -50.h,
            right: -50.w,
            child: _buildBlurCircle(theme.colorScheme.primary.withOpacity(0.12), 280),
          ),
          Positioned(
            top: 200.h,
            left: -100.w,
            child: _buildBlurCircle(theme.colorScheme.secondary.withOpacity(0.08), 240),
          ),
          Positioned(
            bottom: -50.h,
            right: -80.w,
            child: _buildBlurCircle(theme.colorScheme.primary.withOpacity(0.1), 220),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  SizedBox(height: 30.h),
                  _buildSearchBar(),
                  SizedBox(height: 35.h),
                  _buildSectionHeader("Featured Mastery"),
                  SizedBox(height: 20.h),
                  _buildFeaturedList(),
                  SizedBox(height: 40.h),
                  _buildSectionHeader("Top Categories"),
                  SizedBox(height: 20.h),
                  _buildCategoryGrid(),
                  SizedBox(height: 40.h),
                  _buildSectionHeader("Recommended for You"),
                  SizedBox(height: 20.h),
                  _buildCarousel(),
                  SizedBox(height: 40.h),
                  _buildSectionHeader("Trending Now"),
                  SizedBox(height: 20.h),
                  _buildTrendingCard("Digital Marketing", "by John Doe", "assets/images/content-strategy.png"),
                  _buildTrendingCard("Project Management", "by Sarah Lee", "assets/images/project.png"),
                  _buildTrendingCard("UI/UX Design Masterclass", "by Alex Kim", "assets/images/ui.png"),
                  SizedBox(height: 35.h),
                  _buildContinueLearningSection(),
                ],
              ),
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 100,
              spreadRadius: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi Sophia,",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.5),
                )),
            SizedBox(height: 6.h),
            Text(
              "Keep Learning!",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 28.sp,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        _buildIconButton(
          icon: Icons.notifications_none_rounded,
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const NotificationScreen())),
        ),
      ],
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Icon(icon, color: Colors.white, size: 24.sp),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: "Search your passion...",
          prefixIcon: Icon(Icons.search_rounded, size: 22.sp, color: Colors.white.withOpacity(0.3)),
          suffixIcon: Icon(Icons.tune_rounded, color: Theme.of(context).colorScheme.primary, size: 22.sp),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            )),
        Text("View all",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800,
            )),
      ],
    );
  }

  Widget _buildFeaturedList() {
    return SizedBox(
      height: 200.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildFeaturedCard("Data Science & AI", "Advanced Level", Theme.of(context).colorScheme.primary),
          _buildFeaturedCard("Full Stack Flutter", "Intermediate", Theme.of(context).colorScheme.secondary),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(String title, String subtitle, Color color) {
    return Container(
      width: 280.w,
      margin: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Icon(Icons.rocket_launch_rounded, size: 120, color: Colors.white.withOpacity(0.1)),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(subtitle, style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                  ),
                  const Spacer(),
                  Text(title,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22.sp, height: 1.1, letterSpacing: -0.5)),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Text("Start Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14.sp)),
                      SizedBox(width: 8.w),
                      Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18.sp),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 15.w,
      mainAxisSpacing: 15.h,
      childAspectRatio: 2.2,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildCategoryCard(Icons.palette_rounded, "Design", Colors.purpleAccent),
        _buildCategoryCard(Icons.code_rounded, "Coding", Colors.blueAccent),
        _buildCategoryCard(Icons.trending_up_rounded, "Business", Colors.orangeAccent),
        _buildCategoryCard(Icons.psychology_rounded, "Soft Skills", Colors.greenAccent),
      ],
    );
  }

  Widget _buildCategoryCard(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.h,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.85,
        autoPlayInterval: const Duration(seconds: 4),
      ),
      items: _recommendedCourses.map((course) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.r),
            image: DecorationImage(image: AssetImage(course['image']!), fit: BoxFit.cover),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26.r),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.95), Colors.transparent]),
              ),
              padding: EdgeInsets.all(22.w),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course['title']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18.sp, letterSpacing: -0.5)),
                  SizedBox(height: 4.h),
                  Text(course['subtitle']!, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTrendingCard(String title, String subtitle, String imagePath) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(imagePath, width: 60.w, height: 60.w, fit: BoxFit.cover)),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800, letterSpacing: -0.3)),
                SizedBox(height: 4.h),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13.sp, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(color: Colors.amber.withOpacity(0.12), borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.amber, size: 16.sp),
                SizedBox(width: 4.w),
                Text("4.8", style: TextStyle(color: Colors.amber, fontSize: 12.sp, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueLearningSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.15)),
      ),
      padding: EdgeInsets.all(26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Continue Your Journey",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5)),
          SizedBox(height: 25.h),
          ..._continueCourses.map((course) => _buildContinueLearningCard(course)),
        ],
      ),
    );
  }

  Widget _buildContinueLearningCard(Map<String, dynamic> course) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Image.asset(course['image'], width: 50.w, height: 50.w, fit: BoxFit.cover)),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.sp, color: Colors.white, letterSpacing: -0.3)),
                SizedBox(height: 4.h),
                Text(course['lesson'], style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 14.h),
                LinearProgressIndicator(
                  value: course['progress'],
                  minHeight: 6.h,
                  borderRadius: BorderRadius.circular(10.r),
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
              ],
            ),
          ),
          SizedBox(width: 15.w),
          Text("${(course['progress'] * 100).toInt()}%",
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w900, fontSize: 14.sp)),
        ],
      ),
    );
  }
}
