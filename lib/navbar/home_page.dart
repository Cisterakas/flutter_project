import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting time and date
import 'package:flutter_project/appbar/custom_app_bar.dart'; // Import your custom app bar
import 'package:flutter_project/homepage/pomodor_page.dart'; // Import your Pomodoro page

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _formattedTime = "";
  String _formattedDate = "";

  @override
  void initState() {
    super.initState();
    _updateTimeAndDate();
  }

  void _updateTimeAndDate() {
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('hh:mm a').format(now); // Format time like 09:41 PM
    final String formattedDate = DateFormat('MMMM dd').format(now); // Format date like October 05

    setState(() {
      _formattedTime = formattedTime;
      _formattedDate = formattedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Color(0xfffff8e8), // Use the custom app bar here
      body: Column(
        children: [
          SizedBox(height: 20),
          
          // Time display
          Text(
            _formattedTime,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF718635), // Green color for time
            ),
          ),
          SizedBox(height: 10),
          
          // Date display
          Text(
            _formattedDate,
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFFE36C27), // Orange color for date
            ),
          ),
          SizedBox(height: 30),

          // Pomodoro and Flashcards Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureButton(
                  imagePath: 'lib/assets/pomodoro_icon.png', // Add your image path here
                  label: 'Pomodoro',
                  onTap: () {
                    // Navigate to Pomodoro page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PomodoroPage()),
                    );
                  },
                ),
                _buildFeatureButton(
                  imagePath: 'lib/assets/flashcards_icon.png', // Add your image path here
                  label: 'Flashcards',
                  onTap: () {
                    // Add navigation for Flashcards if you have a corresponding page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => FlashcardsPage()),
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureButton({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4, // Responsive width
        height: 150,
        decoration: BoxDecoration(
          color: Color(0xFFD5E1B5), // Background color for the button
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 60,
              height: 60,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
