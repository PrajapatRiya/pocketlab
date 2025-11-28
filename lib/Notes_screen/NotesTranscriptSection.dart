import 'package:flutter/material.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Notes / Transcripts",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.015),

            Row(
              children: [
                buildTab("Notes", 0, screenWidth, screenHeight),
                SizedBox(width: screenWidth * 0.025),
                buildTab("Transcripts", 1, screenWidth, screenHeight),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: selectedTab == 0
                    ? buildNotesSection(screenWidth, screenHeight)
                    : buildTranscriptSection(screenWidth, screenHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------ TAB BUTTON ------------------
  Widget buildTab(String title, int index, double w, double h) {
    bool active = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: h * 0.016),
          decoration: BoxDecoration(
            gradient: active
                ? const LinearGradient(
                colors: [Color(0xFF4869B1), Color(0xFF2E4A8F)])
                : const LinearGradient(colors: [Color(0xFF1A1F28), Color(0xFF1A1F28)]),
            borderRadius: BorderRadius.circular(w * 0.04),
            boxShadow: active
                ? [
              BoxShadow(
                color: Colors.blue.withOpacity(0.4),
                blurRadius: w * 0.03,
                offset: Offset(0, h * 0.005),
              )
            ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : Colors.grey.shade500,
              fontWeight: FontWeight.w600,
              fontSize: w * 0.04,
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ NOTES SECTION ------------------
  Widget buildNotesSection(double w, double h) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Center(
            child: ElevatedButton(
              onPressed: () => addNoteDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4869B1),
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.035,
                  vertical: h * 0.013,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.035),
                ),
                elevation: 6,
                shadowColor: Colors.blue.withOpacity(0.4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: w * 0.045),
                  SizedBox(width: w * 0.02),
                  Text(
                    "Add Note",
                    style: TextStyle(
                      fontSize: w * 0.038,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

            ),
          ),
        ),

        SizedBox(height: h * 0.02),

        Expanded(
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(vertical: h * 0.012),
                padding: EdgeInsets.all(w * 0.01),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1F28),
                  borderRadius: BorderRadius.circular(w * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: w * 0.03,
                      offset: Offset(0, h * 0.007),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(w * 0.035),
                  leading: Container(
                    padding: EdgeInsets.all(w * 0.03),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4869B1),
                      borderRadius: BorderRadius.circular(w * 0.04),
                    ),
                    child:
                    Icon(Icons.edit_note, color: Colors.white, size: w * 0.07),
                  ),
                  title: Text(
                    notes[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red, size: w * 0.07),
                    onPressed: () {
                      setState(() => notes.removeAt(index));
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ------------------ TRANSCRIPT SECTION ------------------
  Widget buildTranscriptSection(double w, double h) {
    String transcriptText = """
This is sample transcript for the video.
All spoken content is shown here.

→ 00:05 Introduction
→ 00:12 Topic explanation
→ 01:20 Example demonstration
→ 03:00 Summary
""";

    return Container(
      padding: EdgeInsets.all(w * 0.045),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F28),
        borderRadius: BorderRadius.circular(w * 0.045),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: w * 0.03,
            offset: Offset(0, h * 0.007),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.copy, color: Colors.white70, size: w * 0.055),
              SizedBox(width: w * 0.03),
              Icon(Icons.share, color: Colors.white70, size: w * 0.055),
              SizedBox(width: w * 0.04),
              Icon(Icons.download, color: Colors.white70, size: w * 0.055),
            ],
          ),

          SizedBox(height: h * 0.015),

          Expanded(
            child: SingleChildScrollView(
              child: Text(
                transcriptText,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: w * 0.04,
                  height: 1.45,
                ),
              ),
            ),
          ),

          SizedBox(height: h * 0.02),

          // ⭐⭐⭐ ADDED: MARK AS COMPLETE BUTTON ⭐⭐⭐
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor:Color(0xFF4869B1),
                    content: const Text("Marked as Complete"),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                padding: EdgeInsets.symmetric(
                  vertical: h * 0.018,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.035),
                ),
                elevation: 6,
                shadowColor: Colors.green.withOpacity(0.4),
              ),
              child: Text(
                "Mark as Complete",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // ⭐⭐⭐ END ⭐⭐⭐
        ],
      ),
    );
  }

  // ------------------ ADD NOTE POPUP ------------------
  void addNoteDialog() {
    TextEditingController controller = TextEditingController();

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F28),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(w * 0.04),
        ),

        title: Center(
          child: Text(
            "Add Note",
            style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.05,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        content: SizedBox(
          width: w * 0.8,
          height: h * 0.12,
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "Write your note here...",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF0F1216),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.035),
              ),
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white70),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => notes.add(controller.text));
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4869B1),
            ),
            child: const Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
