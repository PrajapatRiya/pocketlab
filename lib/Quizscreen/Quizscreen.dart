import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketlab/AttemptScreen/AttemptScreen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> quizData = [
    {
      "question": "Flutter uses which programming language?",
      "options": ["Kotlin", "Dart", "Swift", "Java"],
      "answer": 1,
      "selected": null
    },
    {
      "question": "Which one is NOT a programming language?",
      "options": ["Python", "C++", "HTML", "Java"],
      "answer": 2,
      "selected": null
    },
    {
      "question": "Which company developed Android?",
      "options": ["Apple", "Microsoft", "Google", "IBM"],
      "answer": 2,
      "selected": null
    },
    {
      "question": "Which is a database?",
      "options": ["React", "MySQL", "HTML", "Flutter"],
      "answer": 1,
      "selected": null
    },
    {
      "question": "What does CPU stand for?",
      "options": [
        "Central Processing Unit",
        "Computer Personal Unit",
        "Control Processing Utility",
        "Central Power Unit"
      ],
      "answer": 0,
      "selected": null
    },
    {
      "question": "Which is a version control tool?",
      "options": ["Git", "Flutter", "Docker", "VS Code"],
      "answer": 0,
      "selected": null
    },
    {
      "question": "Who owns GitHub?",
      "options": ["Apple", "Google", "Microsoft", "Amazon"],
      "answer": 2,
      "selected": null
    },
    {
      "question": "RAM stands for?",
      "options": [
        "Random Access Memory",
        "Run Action Method",
        "Read Assembly Machine",
        "Remote Access Mode"
      ],
      "answer": 0,
      "selected": null
    },
  ];

  int score = 0;

  void submitQuiz() {
    score = 0;
    for (var q in quizData) {
      if (q["selected"] == q["answer"]) {
        score++;
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1B1B2F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          title: Text(
            "Quiz Completed!",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 60.sp),
              SizedBox(height: 20.h),
              Text(
                "You scored $score out of ${quizData.length}",
                style: TextStyle(fontSize: 18.sp, color: Colors.white70),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                "Great",
                style: TextStyle(fontSize: 16.sp, color: const Color(0xFF7B5FFF), fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background Glow Effects (Same as Dashboard)
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlurCircle(theme.colorScheme.primary.withOpacity(0.12), 250),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: _buildBlurCircle(theme.colorScheme.secondary.withOpacity(0.08), 200),
          ),
          
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                    physics: const BouncingScrollPhysics(),
                    itemCount: quizData.length,
                    itemBuilder: (context, index) => _buildQuestionCard(index),
                  ),
                ),
                _buildBottomAction(),
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
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
          Text(
            "Pocket Quiz",
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

  Widget _buildQuestionCard(int index) {
    final q = quizData[index];
    final theme = Theme.of(context);
    
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text("${index + 1}", 
                  style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w900, fontSize: 12.sp)),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  q["question"],
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          ...List.generate(q["options"].length, (optIndex) {
            bool isSelected = q["selected"] == optIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  q["selected"] = optIndex;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: 14.h),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.primary.withOpacity(0.1) : Colors.white.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected ? theme.colorScheme.primary : Colors.white.withOpacity(0.05),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                      color: isSelected ? theme.colorScheme.primary : Colors.white24,
                      size: 22.sp,
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Text(
                        q["options"][optIndex],
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.white60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 35.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B2F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          if (quizData.any((q) => q["selected"] != null))
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttemptScreen(attemptData: quizData),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.colorScheme.primary),
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                ),
                child: Text("Review", style: TextStyle(color: theme.colorScheme.primary, fontSize: 16.sp, fontWeight: FontWeight.w900)),
              ),
            ),
          if (quizData.any((q) => q["selected"] != null)) SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton(
              onPressed: submitQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                padding: EdgeInsets.symmetric(vertical: 18.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                elevation: 10,
                shadowColor: theme.colorScheme.primary.withOpacity(0.3),
              ),
              child: Text(
                "Submit Quiz",
                style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
