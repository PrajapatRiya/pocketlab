import 'package:flutter/material.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.01),

              /// ---------------------- AppBar ----------------------
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailPage(),
                            ),
                          );
                        },
                        child: Text(
                          "All Courses",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.05,
                    width: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const VideoPlayerScreen()),
                        );
                      },
                      icon: Image.asset(
                        "assets/images/video-player.png",
                        height: screenHeight * 0.025,
                        width: screenWidth * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.01),

              /// ---------------------- Search Bar ----------------------
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search for courses...",
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF2E2E5E),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.030),

              /// ---------------------- Category Tabs ----------------------
              SizedBox(
                height: screenHeight * 0.05,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    categoryChip("All", selectedCategory == "All", screenWidth),
                    categoryChip("Development",
                        selectedCategory == "Development", screenWidth),
                    categoryChip("Design", selectedCategory == "Design",
                        screenWidth),
                    categoryChip("Business", selectedCategory == "Business",
                        screenWidth),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              /// ---------------------- FIXED COURSE LIST ----------------------
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    final course = filteredCourses[index];

                    return Container(
                      margin:
                      EdgeInsets.only(bottom: screenHeight * 0.015),
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A6A),
                        borderRadius:
                        BorderRadius.circular(screenWidth * 0.03),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Image
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  screenWidth * 0.015),
                              image: DecorationImage(
                                image: AssetImage(course["image"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBox(width: screenWidth * 0.04),

                          /// Details + Progress
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course["title"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.038,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.003),

                                Text(
                                  course["author"],
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: screenWidth * 0.028,
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.004),

                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    SizedBox(
                                        width: screenWidth * 0.01),
                                    Text(
                                      "${course["rating"]} ${course["reviews"]}",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: screenWidth * 0.028,
                                      ),
                                    ),
                                    SizedBox(
                                        width: screenWidth * 0.04),
                                    Text(
                                      course["level"],
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: screenWidth * 0.028,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: screenHeight * 0.01),

                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const CompletionCertificateScreen(),
                                      ),
                                    );
                                  },
                                  child: LinearPercentIndicator(
                                    lineHeight: screenHeight * 0.01,
                                    percent: course["progress"],
                                    animation: true,
                                    animationDuration: 600,
                                    barRadius:
                                    const Radius.circular(20),
                                    backgroundColor: Colors.white12,
                                    progressColor: Colors.blue,
                                    trailing: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "${(course["progress"] * 100).toInt()}%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.028,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Category Chip
  Widget categoryChip(String text, bool selected, double screenWidth) {
    return Container(
      margin: EdgeInsets.only(right: screenWidth * 0.03),
      child: InkWell(
        onTap: () => setState(() => selectedCategory = text),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.018,
          ),
          decoration: BoxDecoration(
            color:
            selected ? Colors.blue.shade600 : const Color(0xFF2E2E5E),
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.03,
            ),
          ),
        ),
      ),
    );
  }
}
