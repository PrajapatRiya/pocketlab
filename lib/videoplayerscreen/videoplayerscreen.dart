import 'package:flutter/material.dart';
import 'package:pocketlab/mycoursescreen/mycoursescreen.dart';
import 'package:video_player/video_player.dart';

import '../Notes_screen/NotesTranscriptSection.dart';
import '../Quizscreen/Quizscreen.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  Duration? _savedPosition;

  int selectedTab = 1;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        ),
      )
      ..initialize().then((_) {
        setState(() {});

        if (_savedPosition != null) {
          _controller.seekTo(_savedPosition!);
        }
      });

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        _controller.pause();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _savedPosition = _controller.value.position;
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTab(String text, int index) {
    bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 40,
              color: Colors.purpleAccent,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final safePadding = MediaQuery.of(context).padding;

    const double topBarHeight = 50.0;
    const double lessonInfoHeight = 80.0;
    const double tabsHeight = 40.0;
    const double bottomNavHeight = 60.0;
    const double spacingHeight = 40.0;

    final availableHeight =
        screenHeight -
        safePadding.top -
        safePadding.bottom -
        topBarHeight -
        lessonInfoHeight -
        tabsHeight -
        bottomNavHeight -
        spacingHeight;

    final videoHeight = (screenWidth * 1.5).clamp(0.0, availableHeight);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // VIDEO AREA
              Container(
                color: Colors.black,
                width: screenWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyCourseScreen(),
                                ),
                              );
                            },
                            child: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                          Text(
                            "UI/UX for Beginners",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.bookmark_border, color: Colors.white),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: videoHeight,
                        maxWidth: screenWidth,
                      ),
                      child: AspectRatio(
                        aspectRatio:
                            _controller.value.isInitialized
                                ? _controller.value.aspectRatio
                                : 16 / 9,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            VideoPlayer(_controller),
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                color: Colors.white,
                                size: screenWidth * 0.15,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // LESSON INFO
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "1. Introduction to\n UI/UX",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      "Design Principles",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ],
                ),
              ),

              // TABS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTab("Lessons", 0),
                    _buildTab("Notes", 1),

                    // Quiz ke liye direct simple text + navigation
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QuizScreen()),
                        );
                      },
                      child: const Text(
                        "Quiz",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // NOTES TAB
              if (selectedTab == 1)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E2C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          maxLines: null,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                          ),
                          decoration: InputDecoration(
                            hintText: "Add a note...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.04,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.020),
                      Row(
                        children: [
                          Icon(
                            Icons.format_bold,
                            color: Colors.white70,
                            size: screenWidth * 0.06,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Icon(
                            Icons.format_italic,
                            color: Colors.white70,
                            size: screenWidth * 0.06,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Icon(
                            Icons.format_underline,
                            color: Colors.white70,
                            size: screenWidth * 0.06,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              SizedBox(height: screenHeight * 0.05),

              // BOTTOM BUTTONS — CORRECTED POSITION
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                  bottom: safePadding.bottom + screenHeight * 0.015,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: screenWidth * 0.05,
                          ),
                          label: Text(
                            "Previous",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotesTranscriptSection(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: screenWidth * 0.05,
                          ),
                          label: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: screenHeight * 0.070),

                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: screenWidth * 0.3,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4869b1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                            ),
                          ),
                          child: Text(
                            "Add Note",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
