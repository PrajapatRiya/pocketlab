import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesTranscriptSection extends StatefulWidget {
  const NotesTranscriptSection({super.key});

  @override
  State<NotesTranscriptSection> createState() => _NotesTranscriptSectionState();
}

class _NotesTranscriptSectionState extends State<NotesTranscriptSection> {
  int selectedTab = 0;

  List<String> notes = [
    "Chapter 1 important points",
    "Video timestamp 03:15 - Example explanation",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notes & Transcripts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _buildTabSelector(),
            SizedBox(height: 25.h),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: selectedTab == 0 ? _buildNotesSection() : _buildTranscriptSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      height: 50.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          _tabItem("Notes", 0),
          _tabItem("Transcripts", 1),
        ],
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    bool isActive = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF7B5FFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white38,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Column(
      key: const ValueKey(0),
      children: [
        GestureDetector(
          onTap: () => _addNoteDialog(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFF7B5FFF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: const Color(0xFF7B5FFF).withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded, color: const Color(0xFF7B5FFF), size: 20.sp),
                SizedBox(width: 8.w),
                Text("Add New Note", style: TextStyle(color: const Color(0xFF7B5FFF), fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: notes.length,
            itemBuilder: (context, index) => _buildNoteItem(index),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteItem(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.sticky_note_2_rounded, color: Colors.amber, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              notes[index],
              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => notes.removeAt(index)),
            icon: Icon(Icons.delete_outline_rounded, color: Colors.redAccent.withOpacity(0.5), size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildTranscriptSection() {
    return Container(
      key: const ValueKey(1),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _transcriptAction(Icons.content_copy_rounded),
              SizedBox(width: 15.w),
              _transcriptAction(Icons.share_rounded),
              SizedBox(width: 15.w),
              _transcriptAction(Icons.download_rounded),
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                "This is sample transcript for the video.\nAll spoken content is shown here.\n\n→ 00:05 Introduction\n→ 00:12 Topic explanation\n→ 01:20 Example demonstration\n→ 03:00 Summary",
                style: TextStyle(color: Colors.white70, fontSize: 14.sp, height: 1.6),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B5FFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text("Mark Lesson as Complete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transcriptAction(IconData icon) {
    return Icon(icon, color: Colors.white38, size: 20.sp);
  }

  void _addNoteDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B1B2F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text("Add New Note", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Enter your note...",
            hintStyle: TextStyle(color: Colors.white24, fontSize: 14.sp),
            filled: true,
            fillColor: Colors.black.withOpacity(0.2),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.white38))),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => notes.add(controller.text));
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7B5FFF)),
            child: const Text("Save Note", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
