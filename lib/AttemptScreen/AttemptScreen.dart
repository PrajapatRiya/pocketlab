import 'package:flutter/material.dart';

class AttemptScreen extends StatelessWidget {
  final List<Map<String, dynamic>> attemptData;

  const AttemptScreen({super.key, required this.attemptData});

  @override
  Widget build(BuildContext context) {

    // ⭐ Screen Dimensions (as you asked)
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black, // black background

      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "Attempted Questions",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // ⭐ using screenWidth
        child: ListView.builder(
          itemCount: attemptData.length,
          itemBuilder: (context, index) {
            final q = attemptData[index];

            return Container(
              margin: EdgeInsets.only(bottom: screenHeight * 0.02), // ⭐ using screenHeight
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    q["question"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),

                  Text(
                    q["selected"] == null
                        ? "Not Attempted"
                        : "Selected: ${q["options"][q["selected"]]}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: screenWidth * 0.04, // ⭐ responsive text
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
