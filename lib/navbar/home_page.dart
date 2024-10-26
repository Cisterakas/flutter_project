import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting time and date
import 'package:flutter_project/appbar/custom_app_bar.dart'; // Import your custom app bar
import 'package:flutter_project/homepage/pomodor_page.dart'; // Import your Pomodoro page
import 'package:flutter_project/homepage/flashcard_page.dart'; // Import your Flashcard page
import 'package:fl_chart/fl_chart.dart'; // For bar chart

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
      backgroundColor: const Color(0xfffff8e8), // Use the custom app bar here
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Time display
            Text(
              _formattedTime,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF718635), // Green color for time
              ),
            ),
            const SizedBox(height: 10),
            
            // Date display
            Text(
              _formattedDate,
              style: const TextStyle(
                fontSize: 24,
                color: Color(0xFFE36C27), // Orange color for date
              ),
            ),
            const SizedBox(height: 30),

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
                      // Navigate to Flashcard page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FlashcardPage()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Weekly Data Bar Chart
            _buildWeeklyBarChart(),

            const SizedBox(height: 20),

            // Schedule Section with Submenu
            _buildScheduleSection(),
          ],
        ),
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
          color: const Color(0xFFD5E1B5), // Background color for the button
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
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
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

  Widget _buildWeeklyBarChart() {
    return SizedBox(
      width: 300, // Set specific width
      height: 200, // Set specific height
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                toY: 2.5,
                color: Colors.orange,
              )
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                toY: 3.5,
                color: Colors.orange,
              )
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                toY: 5,
                color: Colors.orange,
              )
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                toY: 3,
                color: Colors.orange,
              )
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(
                toY: 4,
                color: Colors.orange,
              )
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(
                toY: 4.5,
                color: Colors.green,
              )
            ]),
            BarChartGroupData(x: 6, barRods: [
              BarChartRodData(
                toY: 2,
                color: Colors.orange,
              )
            ]),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                  return Text(days[value.toInt()]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Schedule',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.orange),
                onPressed: () {
                  // Add your schedule action
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Submenu: Classes, Exam, Tasks, Events
        DefaultTabController(
          length: 4, // Number of tabs
          child: Column(
            children: [
              const TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black87,
                tabs: [
                  Tab(text: "Classes"),
                  Tab(text: "Exam"),
                  Tab(text: "Tasks"),
                  Tab(text: "Events"),
                ],
              ),
              Container(
                height: 200, // Height for the tab content
                child: const TabBarView(
                  children: [
                    // Add your list views for each category
                    Center(child: Text("Classes list here")),
                    Center(child: Text("Exam list here")),
                    Center(child: Text("Tasks list here")),
                    Center(child: Text("Events list here")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
