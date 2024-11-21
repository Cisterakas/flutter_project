import 'package:flutter/material.dart';
import 'package:flutter_project/flashcard/flashcard_view_page.dart';
import 'package:flutter_project/appbar/custom_app_bar.dart';
import 'package:flutter_project/flashcard/create_flashcard_page.dart';

class FlashcardPage extends StatefulWidget {
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  // Example flashcard sets with duration
  final List<Map<String, dynamic>> _flashcardSets = [
    {
      'title': 'Title 1',
      'description': 'Description of Set 1',
      'cards': [
        {'term': 'Question 1', 'definition': 'Answer 1'},
        {'term': 'Question 2', 'definition': 'Answer 2'},
      ],
      'duration': 30, // 30 seconds per card
    },
    {
      'title': 'Title 2',
      'description': 'Description of Set 2',
      'cards': [
        {'term': 'Question A', 'definition': 'Answer A'},
        {'term': 'Question B', 'definition': 'Answer B'},
        {'term': 'Question C', 'definition': 'Answer C'},
      ],
      'duration': 45, // 45 seconds per card
    },
  ];

  void _navigateToCreateFlashcardPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateFlashcardPage(
          onFlashcardCreated: (newFlashcardSet) {
            setState(() {
              _flashcardSets.add(newFlashcardSet);
            });
          },
        ),
      ),
    );
  }

  void _navigateToEditFlashcardPage(int index) {
    final flashcardSet = _flashcardSets[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateFlashcardPage(
          onFlashcardCreated: (editedFlashcardSet) {
            setState(() {
              _flashcardSets[index] = editedFlashcardSet;
            });
          },
          initialData: flashcardSet, // Pass initial data to edit
        ),
      ),
    );
  }

  void _deleteFlashcardSet(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Flashcard Set'),
          content: Text('Are you sure you want to delete this flashcard set?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel action
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _flashcardSets.removeAt(index);
                });
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Flashcard set deleted')),
                );
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlashcardSetItem(Map<String, dynamic> flashcardSet, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FlashcardViewPage(
              title: flashcardSet['title'],
              description: flashcardSet['description'],
              cards: flashcardSet['cards'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFD5E1B5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              // Flashcard Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flashcardSet['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    flashcardSet['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Duration: ${flashcardSet['duration']} seconds',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),

              // Edit and Delete Buttons
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _navigateToEditFlashcardPage(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteFlashcardSet(index),
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
                  onPressed: _navigateToCreateFlashcardPage,
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

          // List of flashcard sets
          Expanded(
            child: ListView.builder(
              itemCount: _flashcardSets.length,
              itemBuilder: (context, index) {
                return _buildFlashcardSetItem(_flashcardSets[index], index);
              },
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
}
