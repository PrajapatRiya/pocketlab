import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  int selectedTab = 0; // 0: Lessons, 1: Notes

  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];
  int currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrls[currentVideoIndex]),
    )..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background Glow Effects
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlurCircle(theme.colorScheme.primary.withValues(alpha: 0.1), 250),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: _buildBlurCircle(theme.colorScheme.secondary.withValues(alpha: 0.08), 200),
          ),
          
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                
                // Video Player Container with Glow
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.2), blurRadius: 30, spreadRadius: -10)
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: _buildVideoPlayer(),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        _buildVideoTitle(),
                        SizedBox(height: 30.h),
                        _buildTabs(),
                        SizedBox(height: 25.h),
                        Expanded(child: _buildTabContent()),
                        _buildBottomControls(),
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

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
          ),
          Text("Course Player", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : const Center(child: CircularProgressIndicator(color: Color(0xFF6366F1))),
          
          if (_controller.value.isInitialized)
            GestureDetector(
              onTap: () {
                setState(() {
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                });
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _controller.value.isPlaying ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Icon(
                        _controller.value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: Theme.of(context).colorScheme.primary,
                bufferedColor: Colors.white24,
                backgroundColor: Colors.white10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text("LESSON ${currentVideoIndex + 1}", 
                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w900, fontSize: 11.sp, letterSpacing: 1)),
            ),
            Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.amber, size: 18.sp),
                SizedBox(width: 4.w),
                Text("4.9", style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Text(
          "Introduction to Modern UI/UX Design Principles",
          style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900, letterSpacing: -0.5, height: 1.2),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          _tabButton("Lessons", 0),
          _tabButton("Key Notes", 1),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen())),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text("Take Quiz", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13.sp, fontWeight: FontWeight.w900)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    bool isActive = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white38,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    if (selectedTab == 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          bool isPlaying = currentVideoIndex == index;
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isPlaying ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: isPlaying ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3) : Colors.transparent),
            ),
            child: ListTile(
              onTap: () {
                _controller.pause();
                _controller.dispose();
                setState(() => currentVideoIndex = index);
                _initializeVideo();
              },
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: isPlaying ? Theme.of(context).colorScheme.primary : Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 22.sp),
              ),
              title: Text("Lesson ${index + 1}: ${index == 0 ? 'Foundation' : 'Deep Analysis'}", 
                style: TextStyle(color: isPlaying ? Colors.white : Colors.white70, fontSize: 14.sp, fontWeight: FontWeight.w800)),
              subtitle: Text("10:45 min • High Quality", style: TextStyle(color: Colors.white30, fontSize: 11.sp, fontWeight: FontWeight.w600)),
              trailing: Icon(Icons.check_circle_rounded, color: Colors.green.withValues(alpha: 0.5), size: 20.sp),
            ),
          );
        },
      );
    } else {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "What are your key takeaways from this lesson?",
                  hintStyle: TextStyle(color: Colors.white24, fontSize: 14.sp),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  elevation: 10,
                  shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                ),
                child: Text("Save Key Note", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15.sp)),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildBottomControls() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navButton("Previous", Icons.arrow_back_ios_new_rounded, currentVideoIndex > 0 ? () {
            _controller.pause();
            _controller.dispose();
            setState(() => currentVideoIndex--);
            _initializeVideo();
          } : null),
          _navButton("Next Lesson", Icons.arrow_forward_ios_rounded, currentVideoIndex < videoUrls.length - 1 ? () {
            _controller.pause();
            _controller.dispose();
            setState(() => currentVideoIndex++);
            _initializeVideo();
          } : () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotesTranscriptSection()));
          }, isForward: true),
        ],
      ),
    );
  }

  Widget _navButton(String label, IconData icon, VoidCallback? onTap, {bool isForward = false}) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12.w)),
      child: Row(
        children: [
          if (!isForward) Icon(icon, color: onTap == null ? Colors.white12 : Colors.white70, size: 16.sp),
          if (!isForward) SizedBox(width: 10.w),
          Text(label, style: TextStyle(
            color: onTap == null ? Colors.white12 : Colors.white, 
            fontSize: 14.sp, 
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5)),
          if (isForward) SizedBox(width: 10.w),
          if (isForward) Icon(icon, color: onTap == null ? Colors.white12 : Colors.white70, size: 16.sp),
        ],
      ),
    );
  }
}
