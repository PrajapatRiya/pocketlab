import 'package:flutter/material.dart';
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
          backgroundColor: Colors.grey.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            "Quiz Completed!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: Text(
            "You scored $score out of ${quizData.length}",
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
          actions: [
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(fontSize: 17, color: Colors.indigoAccent),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  // --------------------- Question UI ---------------------
  Widget buildQuestion(int index, double screenWidth) {
    final q = quizData[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q${index + 1}. ${q["question"]}",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),

        Column(
          children: List.generate(q["options"].length, (optIndex) {
            bool isSelected = q["selected"] == optIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  q["selected"] = optIndex;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.012,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white12,
                      width: 0.6,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: isSelected ? Colors.indigoAccent : Colors.white60,
                      size: screenWidth * 0.055,
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      q["options"][optIndex],
                      style: TextStyle(
                        fontSize: screenWidth * 0.038,
                        fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.indigoAccent : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 25),
        Container(height: 1, color: Colors.white12),
        const SizedBox(height: 10),
      ],
    );
  }

  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Quiz",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: ListView(
          children: [
            ...List.generate(
              quizData.length,
                  (index) => buildQuestion(index, screenWidth),
            ),

            SizedBox(height: screenHeight * 0.03),

            // ------------------ SUBMIT QUIZ ------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.018,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Submit Quiz",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // --------------------------------------------------
            // ⭐⭐ Attempt Quiz Button (ONLY IF at least 1 selected)
            // --------------------------------------------------
            if (quizData.any((q) => q["selected"] != null))
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AttemptScreen(attemptData: quizData),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.018,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    "Attempt Quiz",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            // --------------------------------------------------
          ],
        ),
      ),
    );
  }
}
