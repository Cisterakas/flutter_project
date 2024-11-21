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

  // List to store schedules
  List<Map<String, String>> _classes = [];

  @override
  void initState() {
    super.initState();
    _updateTimeAndDate();
  }

  void _updateTimeAndDate() {
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('hh:mm a').format(now);
    final String formattedDate = DateFormat('MMMM dd').format(now);

    setState(() {
      _formattedTime = formattedTime;
      _formattedDate = formattedDate;
    });
  }

  void _addNewClass(Map<String, String> newClass) {
    setState(() {
      _classes.add(newClass);
    });
  }

  Widget _buildFeatureButton({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFD5E1B5),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color(0xfffff8e8),
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
                color: Color(0xFF718635),
              ),
            ),
            const SizedBox(height: 10),

            // Date display
            Text(
              _formattedDate,
              style: const TextStyle(
                fontSize: 24,
                color: Color(0xFFE36C27),
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
                    imagePath: 'lib/assets/pomodoro_icon.png',
                    label: 'Pomodoro',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PomodoroPage()),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    imagePath: 'lib/assets/flashcards_icon.png',
                    label: 'Flashcards',
                    onTap: () {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddScheduleModal();
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddScheduleModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (_, controller) {
            return _buildAddScheduleForm(controller);
          },
        );
      },
    );
  }

  Widget _buildAddScheduleForm(ScrollController controller) {
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController teacherController = TextEditingController();
    final TextEditingController roomController = TextEditingController();
    final TextEditingController buildingController = TextEditingController();
    final TextEditingController startTimeController = TextEditingController();
    final TextEditingController endTimeController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add New Class",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: "Subject Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: teacherController,
              decoration: const InputDecoration(
                labelText: "Teacher Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: roomController,
              decoration: const InputDecoration(
                labelText: "Room",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: buildingController,
              decoration: const InputDecoration(
                labelText: "Building",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: startTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Start Time",
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    startTimeController.text = picked.format(context);
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: endTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "End Time",
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    endTimeController.text = picked.format(context);
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add the class to the schedule
                    _addNewClass({
                      'subject': subjectController.text,
                      'teacher': teacherController.text,
                      'room': roomController.text,
                      'building': buildingController.text,
                      'startTime': startTimeController.text,
                      'endTime': endTimeController.text,
                    });
                    Navigator.pop(context); // Close the modal
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyBarChart() {
    return SizedBox(
      width: 300,
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: [
            for (var i = 0; i < 7; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: (i + 1) * 1.5, // Dynamic values for chart
                  color: i == 5 ? Colors.green : Colors.orange,
                ),
              ]),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
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
      // Schedule Header
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
                _showAddScheduleModal(); // Open ModalBottomSheet to add a new schedule
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),

      // TabBar for Classes, Exam, Tasks, Events
      DefaultTabController(
        length: 4, // Number of tabs
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black87,
              indicatorColor: Colors.green,
              tabs: [
                Tab(text: "Classes"),
                Tab(text: "Exam"),
                Tab(text: "Tasks"),
                Tab(text: "Events"),
              ],
            ),
            Container(
              height: 200, // Fixed height for tab content
              child: TabBarView(
                children: [
                  _buildClassesTab(),
                  _buildExamsTab(),
                  _buildTasksTab(),
                  _buildEventsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Classes Tab Content
Widget _buildClassesTab() {
  if (_classes.isEmpty) {
    return const Center(
      child: Text(
        "No Classes.",
        style: TextStyle(color: Colors.green, fontSize: 16),
      ),
    );
  }
  return ListView.builder(
    itemCount: _classes.length,
    itemBuilder: (context, index) {
      final classItem = _classes[index];
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
        child: ListTile(
          title: Text(classItem['subject'] ?? ""),
          subtitle: Text(
            "Teacher: ${classItem['teacher']}\n"
            "Room: ${classItem['room']}, Building: ${classItem['building']}\n"
            "Time: ${classItem['startTime']} - ${classItem['endTime']}",
          ),
        ),
      );
    },
  );
}

// Placeholder content for other tabs
Widget _buildExamsTab() {
  return const Center(
    child: Text(
      "No Exams.",
      style: TextStyle(color: Colors.green, fontSize: 16),
    ),
  );
}

Widget _buildTasksTab() {
  return const Center(
    child: Text(
      "No Tasks.",
      style: TextStyle(color: Colors.green, fontSize: 16),
    ),
  );
}

Widget _buildEventsTab() {
  return const Center(
    child: Text(
      "No Events.",
      style: TextStyle(color: Colors.green, fontSize: 16),
    ),
  );
}
}