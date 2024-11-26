import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting time and date
import 'package:flutter_project/appbar/custom_app_bar.dart'; // Import your custom app bar
import 'package:flutter_project/homepage/pomodor_page.dart'; // Import your Pomodoro page
import 'package:flutter_project/homepage/flashcard_page.dart'; // Import your Flashcard page
import 'package:fl_chart/fl_chart.dart'; // For bar chart

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _formattedTime = "";
  String _formattedDate = "";

   // Separate lists for classes, exams, tasks, and events
  final List<Map<String, String>> _classes = [];
  final List<Map<String, String>> _exams = [];
  final List<Map<String, String>> _tasks = [];
  final List<Map<String, String>> _events = [];

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

  void _addNewExam(Map<String, String> newExam) {
    setState(() {
      _exams.add(newExam);
    });
  }

   void _addNewTask(Map<String, String> newTask) {
    setState(() {
      _tasks.add(newTask);
    });
  }

  void _addNewEvent(Map<String, String> newEvent) {
    setState(() {
      _events.add(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
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
                        MaterialPageRoute(builder: (context) => const PomodoroPage()),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    imagePath: 'lib/assets/flashcards_icon.png',
                    label: 'Flashcards',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FlashcardPage()),
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

            // Schedule Section
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
          initialChildSize: 0.8,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: DefaultTabController(
                length: 4, // Four tabs: Classes, Exams, Tasks, Events
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.green,
                      tabs: [
                        Tab(text: "Classes"),
                        Tab(text: "Exams"),
                        Tab(text: "Tasks"),
                        Tab(text: "Events"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildAddClassForm(controller),
                          _buildAddExamForm(controller),
                          _buildAddTaskForm(controller),
                          _buildAddEventForm(controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAddClassForm(ScrollController controller) {
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController teacherController = TextEditingController();
    final TextEditingController roomController = TextEditingController();
    final TextEditingController buildingController = TextEditingController();
    final TextEditingController startTimeController = TextEditingController();
    final TextEditingController endTimeController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add New Class", style: TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 20),
            TextField(controller: subjectController, decoration: const InputDecoration(labelText: "Subject Name")),
            TextField(controller: teacherController, decoration: const InputDecoration(labelText: "Teacher Name")),
            TextField(controller: roomController, decoration: const InputDecoration(labelText: "Room")),
            TextField(controller: buildingController, decoration: const InputDecoration(labelText: "Building")),
            TextField(
              controller: startTimeController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Start Time"),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                if (picked != null) {
                  setState(() {
                    startTimeController.text = picked.format(context);
                  });
                }
              },
            ),
            TextField(
              controller: endTimeController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "End Time"),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                if (picked != null) {
                  setState(() {
                    endTimeController.text = picked.format(context);
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                _addNewClass({
                  'subject': subjectController.text,
                  'teacher': teacherController.text,
                  'room': roomController.text,
                  'building': buildingController.text,
                  'startTime': startTimeController.text,
                  'endTime': endTimeController.text,
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddExamForm(ScrollController controller) {
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController moduleController = TextEditingController();
    final TextEditingController roomController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final TextEditingController durationController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add New Exam", style: TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 20),
            TextField(controller: subjectController, decoration: const InputDecoration(labelText: "Subject Name")),
            TextField(controller: moduleController, decoration: const InputDecoration(labelText: "Module")),
            TextField(controller: roomController, decoration: const InputDecoration(labelText: "Room")),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Date"),
              onTap: () async {
                DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));
                if (picked != null) {
                  setState(() {
                    dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                  });
                }
              },
            ),
            TextField(
              controller: timeController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Time"),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                if (picked != null) {
                  setState(() {
                    timeController.text = picked.format(context);
                  });
                }
              },
            ),
            TextField(controller: durationController, decoration: const InputDecoration(labelText: "Duration (minutes)"), keyboardType: TextInputType.number),
            ElevatedButton(
              onPressed: () {
                _addNewExam({
                  'subject': subjectController.text,
                  'module': moduleController.text,
                  'room': roomController.text,
                  'date': dateController.text,
                  'time': timeController.text,
                  'duration': durationController.text,
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

 // Add Task Form
  Widget _buildAddTaskForm(ScrollController controller) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController detailsController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add New Task", style: TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 20),
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: detailsController, decoration: const InputDecoration(labelText: "Details")),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Date"),
              onTap: () async {
                DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));
                if (picked != null) {
                  setState(() {
                    dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                  });
                }
              },
            ),
            TextField(
              controller: timeController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Time"),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                if (picked != null) {
                  setState(() {
                    timeController.text = picked.format(context);
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                _addNewTask({
                  'title': titleController.text,
                  'details': detailsController.text,
                  'date': dateController.text,
                  'time': timeController.text,
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  // Add Event Form
  Widget _buildAddEventForm(ScrollController controller) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController detailsController = TextEditingController();
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add New Event", style: TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 20),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: detailsController, decoration: const InputDecoration(labelText: "Details")),
            TextField(
              controller: startDateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Start Date"),
              onTap: () async {
                DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));
                if (picked != null) {
                  setState(() {
                    startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
                  });
                }
              },
            ),
            TextField(
              controller: endDateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "End Date"),
              onTap: () async {
                DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));
                if (picked != null) {
                  setState(() {
                    endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                _addNewEvent({
                  'name': nameController.text,
                  'details': detailsController.text,
                  'startDate': startDateController.text,
                  'endDate': endDateController.text,
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
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
                  toY: (i + 1) * 1.5,
                  color: i == 5 ? Colors.green : Colors.orange,
                ),
              ]),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
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
                  _showAddScheduleModal();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        DefaultTabController(
          length: 4,
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
              SizedBox(
                height: 200,
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

  Widget _buildExamsTab() {
    if (_exams.isEmpty) {
      return const Center(
        child: Text(
          "No Exams.",
          style: TextStyle(color: Colors.green, fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      itemCount: _exams.length,
      itemBuilder: (context, index) {
        final exam = _exams[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          child: ListTile(
            title: Text(exam['subject'] ?? ""),
            subtitle: Text(
              "Module: ${exam['module']}\n"
              "Room: ${exam['room']}\n"
              "Date: ${exam['date']} Time: ${exam['time']}\n"
              "Duration: ${exam['duration']} minutes",
            ),
          ),
        );
      },
    );
  }

 // Tab Content for Tasks
  Widget _buildTasksTab() {
    if (_tasks.isEmpty) {
      return const Center(
        child: Text(
          "No Tasks.",
          style: TextStyle(color: Colors.green, fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          child: ListTile(
            title: Text(task['title'] ?? ""),
            subtitle: Text(
              "Details: ${task['details']}\nDate: ${task['date']} Time: ${task['time']}",
            ),
          ),
        );
      },
    );
  }

  // Tab Content for Events
  Widget _buildEventsTab() {
    if (_events.isEmpty) {
      return const Center(
        child: Text(
          "No Events.",
          style: TextStyle(color: Colors.green, fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      itemCount: _events.length,
      itemBuilder: (context, index) {
        final event = _events[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          child: ListTile(
            title: Text(event['name'] ?? ""),
            subtitle: Text(
              "Details: ${event['details']}\nStart: ${event['startDate']} End: ${event['endDate']}",
            ),
          ),
        );
      },
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
}
