import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketlab/videoplayerscreen/videoplayerscreen.dart';
import '../dashboardscreen/dashboardscreen.dart';
import '../mycoursescreen/mycoursescreen.dart';
import '../profilescreen/profilescreen.dart';

class MainBottomBar extends StatefulWidget {
  const MainBottomBar({super.key});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const DashboardBlueScreen(),
    const MyCourseScreen(),
    const VideoPlayerScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // This allows the body to go behind the floating nav bar
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            backgroundColor: Colors.transparent, // Use the container's color
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.white.withOpacity(0.3),
            showSelectedLabels: true,
            showUnselectedLabels: false, // Cleaner look
            elevation: 0,
            selectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
            onTap: (index) {
              setState(() => currentIndex = index);
            },
            items: [
              _buildNavItem(Icons.grid_view_rounded, "Home", 0),
              _buildNavItem(Icons.book_rounded, "Courses", 1),
              _buildNavItem(Icons.play_circle_fill_rounded, "Video", 2),
              _buildNavItem(Icons.person_rounded, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(icon, size: 24.sp),
      ),
      label: label,
    );
  }
}
