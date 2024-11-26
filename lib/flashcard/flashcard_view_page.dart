import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:flutter_project/appbar/custom_app_bar.dart';

class FlashcardViewPage extends StatefulWidget {
  final String title;
  final String description;
  final List<Map<String, String>> cards;

  const FlashcardViewPage({super.key, 
    required this.title,
    required this.description,
    required this.cards,
  });

  @override
  _FlashcardViewPageState createState() => _FlashcardViewPageState();
}

class _FlashcardViewPageState extends State<FlashcardViewPage> {
  int currentIndex = 0;
  bool isFlipped = false;
  int correctAnswers = 0;
  late Timer timer;
  int remainingTime = 30; // Timer for each question (30 seconds)

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    remainingTime = 30; // Reset timer
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        handleAnswer(false); // Mark as wrong if time runs out
      }
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  void flipCard() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  void handleAnswer(bool isCorrect) {
    stopTimer();
    if (isCorrect) {
      correctAnswers++;
    }

    if (currentIndex < widget.cards.length - 1) {
      setState(() {
        currentIndex++;
        isFlipped = false;
      });
      startTimer(); // Restart the timer for the next card
    } else {
      showScore();
    }
  }

  void restart() {
    setState(() {
      currentIndex = 0;
      correctAnswers = 0;
      isFlipped = false;
    });
    startTimer();
  }

  void showScore() {
    stopTimer();
    final percentage = (correctAnswers / widget.cards.length) * 100;

    // Fun and encouraging messages based on score
    String message;
    if (percentage == 100) {
      message = "Perfect Score! You’re a genius! 🧠✨";
    } else if (percentage >= 80) {
      message = "Great Job! You're on fire! 🔥";
    } else if (percentage >= 50) {
      message = "Good effort! Keep practicing! 💪";
    } else if (percentage > 0) {
      message = "Don’t give up! Try again and ace it! 💡";
    } else {
      message = "Ouch, tough one! Practice makes perfect! 🚀";
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF718635),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 8.0,
                percent: percentage / 100,
                center: Text(
                  "${percentage.toInt()}%",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                progressColor: Colors.orange,
                backgroundColor: Colors.grey.shade200,
              ),
              const SizedBox(height: 10),
              Text(
                "$correctAnswers / ${widget.cards.length}",
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      restart();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5E1B5),
                    ),
                    child: const Text("Restart"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the score dialog
                      Navigator.pop(context); // Exit the flashcard view
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text("Done"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = widget.cards[currentIndex];
    final cardSide = isFlipped ? currentCard['definition'] : currentCard['term'];

    return Scaffold(
      appBar: const CustomAppBar(), // Custom app bar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Back button below the custom app bar
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF718635)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Flashcard description and progress
                  Column(
                    children: [
                      Text(
                        widget.description,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${currentIndex + 1} / ${widget.cards.length}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Timer
                  Text(
                    "Time left: $remainingTime seconds",
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const SizedBox(height: 10),

                  // Flashcard
                  GestureDetector(
                    onTap: flipCard,
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFF718635)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cardSide ?? "",
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Flip Button
                  ElevatedButton(
                    onPressed: flipCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5E1B5),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text(
                      "Click the card to flip",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (isFlipped)
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red, size: 36),
                          onPressed: () => handleAnswer(false),
                        ),
                      if (isFlipped)
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green, size: 36),
                          onPressed: () => handleAnswer(true),
                        ),
                    ],
                  ),

                  // End Button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        showScore();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: const Text(
                        "End",
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}
