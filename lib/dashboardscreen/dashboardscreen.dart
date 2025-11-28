import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _buildDashboard(screenHeight, screenWidth),
      ),
    );
  }

  Widget _buildDashboard(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back,",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  Text(
                    isLoggedIn ? "Sophia!" : "Guest!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.055,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  CircleAvatar(
                    radius: screenWidth * 0.06,
                    backgroundColor: Colors.purple,
                    child: IconButton(
                      icon: Icon(
                        isLoggedIn ? Icons.person : Icons.logout,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.03),

          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search for courses...",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white54),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          _buildSectionHeader("Featured Courses", screenWidth),
          SizedBox(height: screenHeight * 0.015),
          SizedBox(
            height: screenHeight * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return _buildFeaturedCard(
                  index == 0 ? "Mastering Data Science" : "Advanced Web Dev",
                  index == 0 ? "Data Science" : "Web Development",
                  index == 0 ? Colors.purple : const Color(0xFFE45A92),
                  screenWidth,
                  screenHeight,
                );
              },
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          _buildSectionHeader("Categories", screenWidth),
          SizedBox(height: screenHeight * 0.015),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: screenWidth * 0.04,
            mainAxisSpacing: screenHeight * 0.02,
            childAspectRatio: 2.2,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildCategoryCard(Icons.design_services, "Design", Colors.purple),
              _buildCategoryCard(Icons.code, "Coding", Colors.orange),
              _buildCategoryCard(Icons.campaign, "Marketing", Colors.green),
              _buildCategoryCard(Icons.business, "Business", Colors.blue),
            ],
          ),

          SizedBox(height: screenHeight * 0.03),

          _buildSectionHeader("Recommended Courses", screenWidth),
          SizedBox(height: screenHeight * 0.015),
          CarouselSlider(
            options: CarouselOptions(
              height: screenHeight * 0.22,
              enlargeCenterPage: true,
              autoPlay: true,
              viewportFraction: 0.75,
              autoPlayCurve: Curves.easeInOut,
              autoPlayInterval: const Duration(seconds: 4),
            ),
            items: _recommendedCourses.map((course) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          course['image'] ?? 'assets/images/flutter1.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 15,
                          right: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course['title'] ?? 'Unknown Course',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                course['subtitle'] ?? 'No description',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),

          SizedBox(height: screenHeight * 0.03),

          _buildSectionHeader("Trending Courses", screenWidth),
          SizedBox(height: screenHeight * 0.015),
          _buildTrendingCard("Digital Marketing", "by John Doe",
              "assets/images/content-strategy.png"),
          _buildTrendingCard(
              "Project Management", "by Sarah Lee", "assets/images/project.png"),
          _buildTrendingCard(
              "UI/UX Design", "by Alex Kim", "assets/images/ui.png"),

          SizedBox(height: screenHeight * 0.04),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Continue Learning",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                ..._continueCourses.map((course) =>
                    _buildContinueLearningCard(course, screenWidth, screenHeight)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueLearningCard(
      Map<String, dynamic> course, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              course['image'] as String? ?? 'assets/images/flutter1.jpg',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['title'] ?? 'Unknown Course',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                      color: Colors.black),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  course['lesson'] ?? 'No lesson',
                  style: TextStyle(
                      fontSize: screenWidth * 0.035, color: Colors.black54),
                ),
                SizedBox(height: screenHeight * 0.015),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (course['progress'] as double?) ?? 0.0,
                    minHeight: 6,
                    color: Colors.blueAccent,
                    backgroundColor: Colors.blueAccent.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  "${((course['progress'] as double?) ?? 0.0) * 100.toInt()}% complete",
                  style: TextStyle(
                      fontSize: screenWidth * 0.03, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, double screenWidth) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold),
      ),
      Text(
        "See All",
        style: TextStyle(
            color: Colors.purple,
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500),
      ),
    ],
  );

  Widget _buildFeaturedCard(String title, String category, Color color,
      double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.6,
      margin: EdgeInsets.only(right: screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: TextStyle(
              color: Colors.white70,
              fontSize: screenWidth * 0.035,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {},
            child: const Text("Enroll Now"),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(IconData icon, String title, Color color) =>
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A3870).withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildTrendingCard(String title, String subtitle, String imagePath) =>
      Card(
        color: Colors.white.withOpacity(0.08),
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: const Icon(Icons.star, color: Colors.amber),
        ),
      );
}
