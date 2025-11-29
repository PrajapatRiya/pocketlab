import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Dummy notifications list
  List<Map<String, dynamic>> messages = [
    {
      "title": "Welcome!",
      "body": "Thanks for installing the app.",
      "isRead": false,
      "highlight": true,
    },
    {
      "title": "Reminder",
      "body": "Don't forget to check your tasks today.",
      "isRead": false,
      "highlight": false,
    },
    {
      "title": "Update Available",
      "body": "New features added in the latest version.",
      "isRead": false,
      "highlight": false,
    },
  ];

  // Announcements list
  List<Map<String, dynamic>> announcements = [
    {
      "title": "New Course Launched",
      "body": "Flutter Advanced Course is now available!",
    },
    {
      "title": "Special Offer",
      "body": "Get 40% OFF on yearly subscription.",
    }
  ];

  // Show popup dialog
  void _openNotificationDialog(String title, String body) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(body, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.015,
        ),
        children: [
          // ------------------ ANNOUNCEMENT SECTION ------------------
          Text(
            "📢 Announcements",
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),

          ...announcements.map((a) {
            return Container(
              margin: EdgeInsets.only(bottom: screenHeight * 0.012),
              padding: EdgeInsets.all(screenWidth * 0.045),
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a["title"],
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    a["body"],
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: screenHeight * 0.02),

          // ---------------- NOTIFICATIONS SECTION ------------------
          Text(
            "🔔 Notifications",
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),

          ...messages.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;

            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => setState(() => messages.removeAt(index)),
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() => item["isRead"] = true);
                  _openNotificationDialog(item["title"], item["body"]);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                  padding: EdgeInsets.all(screenWidth * 0.045),
                  decoration: BoxDecoration(
                    gradient: item["highlight"]
                        ? const LinearGradient(
                      colors: [Colors.blueAccent, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                        : null,
                    color: item["isRead"] || !item["highlight"]
                        ? Colors.grey[850]
                        : null,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[700]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.01),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.purple],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: screenWidth * 0.065,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: screenWidth * 0.06,
                          ),
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.04),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"],
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: item["highlight"]
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              item["body"],
                              style: TextStyle(
                                fontSize: screenWidth * 0.038,
                                color: item["highlight"]
                                    ? Colors.white70
                                    : Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (!item["isRead"])
                        Container(
                          height: screenWidth * 0.03,
                          width: screenWidth * 0.03,
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
