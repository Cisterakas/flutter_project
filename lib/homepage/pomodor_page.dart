import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_project/appbar/custom_app_bar.dart';  // Your custom app bar

class PomodoroPage extends StatefulWidget {
  @override
  _PomodoroPageState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  final CountDownController _controller = CountDownController();
  bool isRunning = false; // To track if the timer is running

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Color(0xfffff8e8),  // Use your custom app bar here
      body: Center(  // Ensure everything is centered
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Vertically center the column
          crossAxisAlignment: CrossAxisAlignment.center, // Horizontally center the children
          children: [
            // Back Button
            Align(
              alignment: Alignment.topLeft, // Align the back button to the top left
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.orange[400]),
                onPressed: () {
                  Navigator.pop(context); // Navigate back when pressed
                },
              ),
            ),
            SizedBox(height: 70), // Adjust height for spacing below the app bar
            
            CircularCountDownTimer(
              duration: 3600, // Set for 60 minutes (3600 seconds)
              initialDuration: 0,
              controller: _controller,
              width: 200.0,
              height: 200.0,
              ringColor: Colors.grey[300]!,
              fillColor: Colors.orange[400]!,
              backgroundColor: Color(0xfffff8e8),
              strokeWidth: 10.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                fontSize: 40.0,
                color: Colors.orange[400],
                fontWeight: FontWeight.bold,
              ),
              isReverse: true, // Count downwards
              onComplete: () {
                setState(() {
                  isRunning = false;
                });
              },
            ),
            SizedBox(height: 20),
            // Play/Pause Button
            IconButton(
              icon: Icon(
                isRunning ? Icons.pause_circle_filled : Icons.play_circle_filled,
                size: 50,
                color: Colors.orange[400],
              ),
              onPressed: () {
                setState(() {
                  if (isRunning) {
                    _controller.pause();
                  } else {
                    _controller.resume();
                  }
                  isRunning = !isRunning;
                });
              },
            ),
            SizedBox(height: 20),
            // Notification Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20), // Add horizontal padding
              child: Text(
                'While your focus mode is on, all of your notifications will be off',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Pomodoro Image at the bottom
            Image.asset(
              'lib/assets/pomodoro_icon.png', // Change this to your image path
              width: 120,
              height: 120,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      // Settings Button on Top Right
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfffff8e8),
        elevation: 0,
        onPressed: () {
          // Open settings when pressed
        },
        child: Icon(Icons.settings, color: Colors.orange[400]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
