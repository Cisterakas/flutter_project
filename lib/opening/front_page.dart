import 'package:flutter/material.dart';
import 'page_view_screen.dart'; // Import the new page view screen

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff8e8), // New color code
      body: GestureDetector(
        onTap: () {
          // Navigate to the main NavBar after screen tap
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageViewScreen()),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
               
              ),
            ),
            Image.asset(
              "lib/assets/MyPlan Logo 2.png", // Ensure the image path is correct
              width: 208,
              height: 161,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
