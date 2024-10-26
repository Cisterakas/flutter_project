import 'package:flutter/material.dart';
import 'package:flutter_project/appbar/custom_app_bar.dart'; // Import your custom app bar
import 'package:flutter_project/flashcard/create_flashcard_page.dart'; // Import your CreateFlashcardPage

class FlashcardPage extends StatefulWidget {
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Add your custom app bar here
      body: Column(
        children: [
          // Back button and Add Card button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF718635)),
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous page
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_box, color: Color(0xFF718635), size: 30),
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateFlashcardPage()),
                  );
                  },
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search sets',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 20),

          // List of flashcards
          Expanded(
            child: ListView(
              children: [
                _buildFlashcardItem('Title 1', 'Description', 'Time Duration'),
                SizedBox(height: 10),
                _buildFlashcardItem('Title 2', 'Description', 'Time Duration'),
                // Add more items as needed
              ],
            ),
          ),

          // Decorative image at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Image.asset(
              'lib/assets/flashcards_icon.png', // Replace with your actual image path
              height: 150,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each flashcard item
  Widget _buildFlashcardItem(String title, String description, String timeDuration) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFFD5E1B5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 4),
            Text(
              timeDuration,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
