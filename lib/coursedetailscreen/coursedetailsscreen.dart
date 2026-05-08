import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:pocketlab/%20SubscriptionScreen/SubscriptionScreen.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  VideoPlayerController? _controller;
  int selectedTabIndex = 0;
  final List<String> tabTitles = ['Description', 'Syllabus', 'Reviews'];
  bool module1Expanded = true;
  bool module3Expanded = false;
  bool _isInitialized = false;
  bool _showVideo = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeVideo(String assetPath) {
    setState(() {
      _showVideo = true;
      _isInitialized = false;
    });
    _controller?.dispose();

    _controller = VideoPlayerController.asset(assetPath);

    _controller!.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _controller!.play();
        _controller!.setLooping(true);
        if (_scrollController.hasClients) {
          _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      }
    }).catchError((error) {
      debugPrint("Video Error: $error");
      if (mounted) {
        setState(() => _showVideo = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Video file error. Please check assets folder.")),
        );
      }
    });
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
            top: -100.h,
            right: -100.w,
            child: _buildBlurCircle(theme.colorScheme.primary.withOpacity(0.1), 250),
          ),
          Positioned(
            bottom: 100.h,
            left: -50.w,
            child: _buildBlurCircle(theme.colorScheme.secondary.withOpacity(0.05), 200),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
                          child: _buildHeroMedia(),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTags(),
                                SizedBox(height: 15.h),
                                Text(
                                  'Introduction to UX Design',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                _buildInstructorInfo(),
                                SizedBox(height: 25.h),
                                _buildInfoGrid(),
                                SizedBox(height: 35.h),
                                _buildTabs(),
                                SizedBox(height: 25.h),
                                _buildTabContent(),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ),
                        ),
                        _buildFixedBottomAction(context),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12.r)),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
          Text("Details", style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w900)),
          const Icon(Icons.bookmark_outline_rounded, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildHeroMedia() {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: Colors.black,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            if (!_showVideo)
              Image.asset('assets/images/logo1.jpg', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
            if (_showVideo && _isInitialized)
              AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: VideoPlayer(_controller!)),
            if (_showVideo && !_isInitialized)
              const Center(child: CircularProgressIndicator(color: Color(0xFF6366F1))),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                ),
              ),
            ),
            if (_isInitialized && _showVideo)
              Center(
                child: GestureDetector(
                  onTap: () => setState(() => _controller!.value.isPlaying ? _controller!.pause() : _controller!.play()),
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTags() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
            child: Text("BESTSELLER", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10.sp, fontWeight: FontWeight.w900, letterSpacing: 1)),
          ),
          SizedBox(width: 12.w),
          const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
          SizedBox(width: 4.w),
          Text("4.9", style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold)),
          Text(" (1.2k reviews)", style: TextStyle(color: Colors.white38, fontSize: 11.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInstructorInfo() {
    return Row(
      children: [
        CircleAvatar(radius: 20.r, backgroundImage: const AssetImage('assets/images/person.png')),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('John Doe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15.sp)),
              Text('Senior UX Designer at Google',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white38, fontSize: 12.sp, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _infoItem(Icons.access_time_rounded, '12 Hours')),
        SizedBox(width: 8.w),
        Expanded(child: _infoItem(Icons.menu_book_rounded, '42 Lessons')),
        SizedBox(width: 8.w),
        Expanded(child: _infoItem(Icons.language_rounded, 'English')),
      ],
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 16.sp),
          SizedBox(width: 6.w),
          Flexible(child: Text(text, style: TextStyle(color: Colors.white70, fontSize: 10.sp, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        tabTitles.length,
            (index) => Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTabIndex = index),
            child: Column(
              children: [
                Text(
                  tabTitles[index],
                  style: TextStyle(
                    color: selectedTabIndex == index ? Colors.white : Colors.white38,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 3.h,
                  width: selectedTabIndex == index ? 30.w : 0,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10.r)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return Text(
          'Master the art of creating delightful user experiences. This course covers everything from user research, wireframing, to interactive prototyping using industry-standard tools.',
          style: TextStyle(color: Colors.white70, fontSize: 14.sp, height: 1.6, fontWeight: FontWeight.w500),
        );
      case 1:
        return Column(
          children: [
            _syllabusItem(
              'Module 01: Introduction to Design',
              [
                _lessonRow('01. Concept of Empathy', 'assets/Video/124255-730503324_medium.mp4'),
                _lessonRow('02. Visual Design Basics', 'assets/Video/14157413_3840_2160_25fps.mp4'),
              ],
              module1Expanded,
                  () => setState(() => module1Expanded = !module1Expanded),
            ),
            SizedBox(height: 12.h),
            _syllabusItem(
              'Module 02: Research & Analysis',
              [
                _lessonRow('01. User Flow Design', 'assets/Video/14157413_3840_2160_25fps.mp4'),
                _lessonRow('02. User Journey Mapping', 'assets/Video/124255-730503324_medium.mp4'),
              ],
              module3Expanded,
                  () => setState(() => module3Expanded = !module3Expanded),
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            _reviewItem('Sarah Wilson', 'The most structured UX course I have ever taken. Extremely helpful!'),
            SizedBox(height: 12.h),
            _reviewItem('Michael Brown', 'Clear explanations and practical examples. Five stars!'),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _syllabusItem(String title, List<Widget> lessons, bool expanded, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (_) => onTap(),
          initiallyExpanded: expanded,
          title: Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w800)),
          trailing: Icon(expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded, color: Colors.white38),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Column(
                children: lessons,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _lessonRow(String title, String url) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: InkWell(
        onTap: () => _initializeVideo(url),
        child: Row(
          children: [
            Icon(Icons.play_circle_fill_rounded, color: Theme.of(context).colorScheme.primary, size: 18.sp),
            SizedBox(width: 12.w),
            Expanded(child: Text(title, style: TextStyle(color: Colors.white70, fontSize: 13.sp, fontWeight: FontWeight.w600))),
            Text("Play", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12.sp, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _reviewItem(String name, String comment) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14.sp)),
              Row(children: List.generate(5, (index) => Icon(Icons.star_rounded, color: Colors.amber, size: 14.sp))),
            ],
          ),
          SizedBox(height: 10.h),
          Text(comment, style: TextStyle(color: Colors.white54, fontSize: 13.sp, fontWeight: FontWeight.w500, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildFixedBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 15.h, 24.w, 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B2F),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
          ),
          child: Text(
            "Enroll Now - ₹2,499",
            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w900, letterSpacing: 0.5),
          ),
        ),
      ),
    );
  }
}
