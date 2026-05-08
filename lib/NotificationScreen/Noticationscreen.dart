import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Dummy notifications list
  List<Map<String, dynamic>> messages = [
    {
      "title": "Welcome to Pocket Lab!",
      "body": "Thanks for joining us. Let's start your learning journey today.",
      "isRead": false,
      "time": "2 mins ago",
    },
    {
      "title": "New Lesson Added",
      "body": "A new lesson has been added to your 'Flutter Development' course.",
      "isRead": false,
      "time": "1 hour ago",
    },
    {
      "title": "Daily Goal Reached",
      "body": "Congratulations! You've completed your study goal for today.",
      "isRead": true,
      "time": "Yesterday",
    },
  ];

  // Announcements list
  List<Map<String, dynamic>> announcements = [
    {
      "title": "New Course Launched",
      "body": "Flutter Advanced Course is now available with 50% discount!",
    },
    {
      "title": "Live Workshop Tomorrow",
      "body": "Join our live Q&A session with industry experts at 6 PM.",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background Glow Effects (Bubbles)
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlurCircle(theme.colorScheme.primary.withValues(alpha: 0.15), 250),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: _buildBlurCircle(theme.colorScheme.secondary.withValues(alpha: 0.1), 200),
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

                        /// ------------------ ANNOUNCEMENT SECTION ------------------
                        _buildSectionHeader("📢 Announcements"),
                        SizedBox(height: 15.h),

                        ...announcements.map((a) => _buildAnnouncementCard(a)),

                        SizedBox(height: 35.h),

                        /// ---------------- NOTIFICATIONS SECTION ------------------
                        _buildSectionHeader("🔔 Recent Notifications"),
                        SizedBox(height: 15.h),

                        messages.isEmpty
                            ? _buildEmptyState()
                            : Column(
                                children: messages.asMap().entries.map((entry) {
                                  return _buildNotificationItem(entry.value, entry.key);
                                }).toList(),
                              ),
                        SizedBox(height: 100.h), 
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
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
          Text(
            "Notifications",
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildAnnouncementCard(Map<String, dynamic> a) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary.withValues(alpha: 0.2), theme.colorScheme.secondary.withValues(alpha: 0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.campaign_rounded, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  a["title"],
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            a["body"],
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> item, int index) {
    final theme = Theme.of(context);
    bool isRead = item["isRead"];
    
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        setState(() => messages.removeAt(index));
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 28),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() => item["isRead"] = true);
          _showNotificationDetail(item);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              color: isRead ? Colors.white.withValues(alpha: 0.05) : theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: (isRead ? Colors.grey : theme.colorScheme.primary).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_active_outlined,
                  color: isRead ? Colors.white24 : theme.colorScheme.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item["title"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: isRead ? FontWeight.w600 : FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          item["time"],
                          style: TextStyle(color: Colors.white24, fontSize: 11.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      item["body"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white54,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 60.h),
          Icon(Icons.notifications_off_outlined, size: 80.sp, color: Colors.white.withValues(alpha: 0.05)),
          SizedBox(height: 20.h),
          Text("All caught up!", style: TextStyle(color: Colors.white24, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showNotificationDetail(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(28.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  child: Text("NOTIFICATION", 
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10.sp, fontWeight: FontWeight.w900, letterSpacing: 1)),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Colors.white38),
                )
              ],
            ),
            SizedBox(height: 20.h),
            Text(item["title"], style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
            SizedBox(height: 8.h),
            Text(item["time"], style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 13.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 25.h),
            Text(item["body"], style: TextStyle(color: Colors.white70, fontSize: 15.sp, height: 1.6, fontWeight: FontWeight.w500)),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  elevation: 8,
                  shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                ),
                child: Text("Got it", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16.sp)),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
