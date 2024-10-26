import 'package:flutter/material.dart';
import 'package:flutter_project/appbar/custom_app_bar.dart'; // Import your custom app bar

class CreateFlashcardPage extends StatefulWidget {
  @override
  _CreateFlashcardPageState createState() => _CreateFlashcardPageState();
}

class _CreateFlashcardPageState extends State<CreateFlashcardPage> {
  List<Map<String, String>> cards = [{'term': '', 'definition': ''}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),  // Add the custom app bar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Back button and Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF718635)),
                  onPressed: () {
                    Navigator.pop(context);  // Go back to the previous page
                  },
                ),
                Text(
                  'Create New Set',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF718635),
                  ),
                ),
                SizedBox(width: 40), // Dummy element for alignment
              ],
            ),
            SizedBox(height: 20),

            // Enter Title
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter a title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),

            // Add Description
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Add a description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),

            // Dynamic list of cards
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                            '${index + 1}',  // Display the card number
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Enter term or question
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    cards[index]['term'] = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter term',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),

                              // Enter definition or answer
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    cards[index]['definition'] = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter definition',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // Add Card Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cards.add({'term': '', 'definition': ''});
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD5E1B5),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                '+ Add Card',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Create Button
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Logic for creating flashcard set
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
