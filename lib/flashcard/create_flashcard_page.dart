import 'package:flutter/material.dart';
import 'package:flutter_project/appbar/custom_app_bar.dart'; // Import your custom app bar

class CreateFlashcardPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onFlashcardCreated;
  final Map<String, dynamic>? initialData; // Optional initial data for editing

  const CreateFlashcardPage({super.key, required this.onFlashcardCreated, this.initialData});

  @override
  _CreateFlashcardPageState createState() => _CreateFlashcardPageState();
}

class _CreateFlashcardPageState extends State<CreateFlashcardPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _durationController;
  late List<Map<String, String>> cards;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data or defaults
    _titleController = TextEditingController(
      text: widget.initialData?['title'] ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialData?['description'] ?? '',
    );
    _durationController = TextEditingController(
      text: widget.initialData?['duration']?.toString() ?? '',
    );
    cards = List<Map<String, String>>.from(
      widget.initialData?['cards'] ?? [{'term': '', 'definition': ''}],
    );
  }

  void _saveFlashcardSet() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title for the flashcard set.')),
      );
      return;
    }

    if (_durationController.text.isEmpty || int.tryParse(_durationController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid duration in seconds.')),
      );
      return;
    }

    for (var card in cards) {
      if (card['term']!.isEmpty || card['definition']!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All terms and definitions must be filled out.')),
        );
        return;
      }
    }

    final newSet = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'duration': int.parse(_durationController.text), // Duration in seconds
      'cards': cards,
    };

    widget.onFlashcardCreated(newSet);
    Navigator.pop(context); // Go back to the flashcard list page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Add the custom app bar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Back button and Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF718635)),
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous page
                  },
                ),
                Text(
                  widget.initialData != null ? 'Edit Flashcard Set' : 'Create New Set',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF718635),
                  ),
                ),
                const SizedBox(width: 40), // Dummy element for alignment
              ],
            ),
            const SizedBox(height: 20),

            // Enter Title
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter a title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            // Add Description
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Add a description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            // Enter Duration
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter duration (seconds per card)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            // Dynamic list of cards
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD5E1B5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${index + 1}', // Display the card number
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    cards.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

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
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  controller: TextEditingController(
                                      text: cards[index]['term']),
                                ),
                              ),
                              const SizedBox(width: 10),

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
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  controller: TextEditingController(
                                      text: cards[index]['definition']),
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
            const SizedBox(height: 20),

            // Add Card Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cards.add({'term': '', 'definition': ''});
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD5E1B5),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                '+ Add Card',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Create Button
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _saveFlashcardSet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  widget.initialData != null ? 'Save Changes' : 'Create',
                  style: const TextStyle(
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
