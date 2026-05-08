import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttemptScreen extends StatelessWidget {
  final List<Map<String, dynamic>> attemptData;

  const AttemptScreen({super.key, required this.attemptData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Review Answers",
          style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        physics: const BouncingScrollPhysics(),
        itemCount: attemptData.length,
        itemBuilder: (context, index) {
          final q = attemptData[index];
          bool isCorrect = q["selected"] == q["answer"];
          bool isNotAttempted = q["selected"] == null;

          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isNotAttempted 
                    ? Colors.white.withOpacity(0.1) 
                    : (isCorrect ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3)),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${index + 1}.",
                      style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        q["question"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _rowInfo("Your Answer:", isNotAttempted ? "Not Attempted" : q["options"][q["selected"]], isNotAttempted ? Colors.white38 : (isCorrect ? Colors.green : Colors.red)),
                      if (!isCorrect && !isNotAttempted) ...[
                        SizedBox(height: 8.h),
                        _rowInfo("Correct Answer:", q["options"][q["answer"]], Colors.green),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _rowInfo(String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white54, fontSize: 12.sp)),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: color, fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
