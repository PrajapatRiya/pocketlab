import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pocketlab/%20SubscriptionScreen/SubscriptionScreen.dart';

import '../loginsignupscreen/login_signupscreen.dart';
import '../videoplayerscreen/videoplayerscreen.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  int selectedTabIndex = 0;
  final List<String> tabTitles = ['Description', 'Syllabus', 'Reviews'];
  bool module1Expanded = false;
  bool module3Expanded = true;
  bool module4Expanded = false;

  // Mock user login state (replace with actual auth later)
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey = "pk_test_51XXXXXXXXXXXXXXXXXXXXXXXXXXXX"; // Apna real key daal dena
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: screenHeight * 0.03,
                    ),
                  ),
                  Text(
                    'Course Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                    size: screenHeight * 0.03,
                  ),
                ],
              ),
            ),

            // Course Thumbnail
            Stack(
              children: [
                Image.asset(
                  'assets/images/logo1.jpg',
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: screenHeight * 0.3,
                      width: screenWidth,
                      color: Colors.grey[800],
                      child: const Center(
                        child: Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Main Content
            Expanded(
              child: Container(
                width: screenWidth,
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: const BoxDecoration(
                  color: Color(0xFF2A2A3D),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Introduction to UX Design',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.028,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: screenHeight * 0.02,
                            backgroundImage: const AssetImage('assets/images/person.png'),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenHeight * 0.018,
                                ),
                              ),
                              Text(
                                'Lead UX Designer at Google',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: screenHeight * 0.014,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Info Cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _InfoCard(icon: Icons.access_time, label: '12 Hours', screenHeight: screenHeight, screenWidth: screenWidth),
                          _InfoCard(icon: Icons.menu_book, label: '42 Lessons', screenHeight: screenHeight, screenWidth: screenWidth),
                          _InfoCard(icon: Icons.language, label: 'English', screenHeight: screenHeight, screenWidth: screenWidth),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Tabs
                      Row(
                        children: List.generate(
                          tabTitles.length,
                              (index) => GestureDetector(
                            onTap: () => setState(() => selectedTabIndex = index),
                            child: _TabItem(
                              title: tabTitles[index],
                              selected: selectedTabIndex == index,
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Tab Content
                      _buildTabContent(screenHeight, screenWidth),

                      SizedBox(height: screenHeight * 0.03),

                      // Enroll Now Button - PROPERLY FIXED
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.065,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SubscriptionScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              'Enroll Now - \$49.99',
                              style: TextStyle(
                                fontSize: screenHeight * 0.022,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(double screenHeight, double screenWidth) {
    switch (selectedTabIndex) {
      case 0: // Description
        return Text(
          'This course is a comprehensive guide to the world of User Experience and Design Skills to create intuitive and user-friendly digital products...',
          style: TextStyle(color: Colors.white54, height: 1.5, fontSize: screenHeight * 0.019),
        );

      case 1: // Syllabus
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Syllabus', style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.028, fontWeight: FontWeight.bold)),
            SizedBox(height: screenHeight * 0.02),
            _buildModule(
              title: 'Module 01 - Introduction to UX',
              expanded: module1Expanded,
              onToggle: () => setState(() => module1Expanded = !module1Expanded),
              lessons: const [
                {"title": "Basics of UX", "time": "10 min", "locked": false},
                {"title": "Principles of UX", "time": "20 min", "locked": true},
              ],
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            SizedBox(height: screenHeight * 0.015),
            _buildModule(
              title: 'Module 03 - Wireframing & Prototyping',
              expanded: module3Expanded,
              onToggle: () => setState(() => module3Expanded = !module3Expanded),
              lessons: const [
                {"title": "Low-Fidelity Wireframing", "time": "15 min", "locked": false},
                {"title": "High-Fidelity Prototyping", "time": "25 min", "locked": false},
                {"title": "Interactive Components", "time": "30 min", "locked": true},
              ],
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            SizedBox(height: screenHeight * 0.015),
            _buildModule(
              title: 'Module 04 - User Testing & Feedback',
              expanded: module4Expanded,
              onToggle: () => setState(() => module4Expanded = !module4Expanded),
              lessons: const [],
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
          ],
        );

      case 2: // Reviews
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Write a Review Box
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(color: const Color(0xFF1F1F2E), borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Write a Review', style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.022)),
                  SizedBox(height: screenHeight * 0.01),
                  Row(children: List.generate(5, (i) => Icon(Icons.star, color: i < 4 ? Colors.orange : Colors.grey, size: screenHeight * 0.025))),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Write your review here...',
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF2A2A3D),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.018),
                    maxLines: 3,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.06,
                    child: DecoratedBox(
                      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]), borderRadius: BorderRadius.circular(25)),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                        child: Text('Submit Review', style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.02)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text('All Reviews', style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.022, fontWeight: FontWeight.bold)),
            SizedBox(height: screenHeight * 0.01),
            _buildReview(name: 'Sarah W.', rating: 5, date: '2 days ago', text: 'Absolutely Worth It! This course exceeded my expectations...', screenHeight: screenHeight),
            _buildReview(name: 'Mike L.', rating: 4, date: '1 week ago', text: 'Great course for beginners! I learned a lot...', screenHeight: screenHeight),
            _buildReview(name: 'Emily R.', rating: 5, date: '3 weeks ago', text: 'Fantastic Learning Experience! The instructor is engaging...', screenHeight: screenHeight),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildModule({
    required String title,
    required bool expanded,
    required VoidCallback onToggle,
    required List<Map<String, dynamic>> lessons,
    required double screenHeight,
    required double screenWidth,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.01),
      decoration: BoxDecoration(color: const Color(0xFF1F1F2E), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            title: Text(title, style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.02)),
            trailing: Icon(expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white54, size: screenHeight * 0.03),
            onTap: onToggle,
          ),
          if (expanded) const Divider(color: Colors.grey, height: 1),
          if (expanded)
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Column(
                children: lessons.map((lesson) {
                  return GestureDetector(
                    onTap: () {
                      if (!(lesson['locked'] as bool)) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>  VideoPlayerScreen()));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
                      child: Row(
                        children: [
                          Icon(
                            lesson["locked"] ? Icons.lock_outline : Icons.play_circle_outline,
                            color: lesson["locked"] ? Colors.white54 : Colors.white70,
                            size: screenHeight * 0.022,
                          ),
                          SizedBox(width: screenWidth * 0.015),
                          Expanded(child: Text(lesson["title"], style: TextStyle(color: Colors.white70, fontSize: screenHeight * 0.018))),
                          Text(lesson["time"], style: TextStyle(color: Colors.white54, fontSize: screenHeight * 0.016)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReview({required String name, required int rating, required String date, required String text, required double screenHeight}) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      padding: EdgeInsets.all(screenHeight * 0.015),
      decoration: BoxDecoration(color: const Color(0xFF1F1F2E), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: screenHeight * 0.02, backgroundImage: const AssetImage('assets/images/person.png')),
              SizedBox(width: screenHeight * 0.015),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: screenHeight * 0.018)),
                Text(date, style: TextStyle(color: Colors.white54, fontSize: screenHeight * 0.014)),
              ]),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(children: List.generate(5, (i) => Icon(Icons.star, color: i < rating ? Colors.orange : Colors.grey, size: screenHeight * 0.02))),
          SizedBox(height: screenHeight * 0.01),
          Text(text, style: TextStyle(color: Colors.white54, fontSize: screenHeight * 0.017)),
        ],
      ),
    );
  }
}

// Reusable Widgets
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final double screenHeight;
  final double screenWidth;

  const _InfoCard({required this.icon, required this.label, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.25,
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(color: const Color(0xFF1F1F2E), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: screenHeight * 0.025),
          SizedBox(height: screenHeight * 0.01),
          Text(label, style: TextStyle(color: Colors.white70, fontSize: screenHeight * 0.014), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool selected;
  final double screenWidth;
  final double screenHeight;

  const _TabItem({required this.title, required this.selected, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: selected ? Colors.white : Colors.white54, fontWeight: FontWeight.w500, fontSize: screenHeight * 0.018),
          ),
          SizedBox(height: screenHeight * 0.005),
          if (selected) Container(height: 2, width: screenWidth * 0.15, color: Colors.purpleAccent),
        ],
      ),
    );
  }
}