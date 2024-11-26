import 'package:flutter/material.dart';
import 'package:flutter_project/add_schedule_modal.dart'; // Import the reusable modal for adding schedules
import 'package:flutter_project/appbar/custom_app_bar.dart'; // Import the custom app bar

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  // Separate lists for activities
  List<Map<String, String>> _classes = [];
  List<Map<String, String>> _exams = [];
  List<Map<String, String>> _tasks = [];
  List<Map<String, String>> _events = [];

  // Filters for tabs
  String _selectedSubject = "All Subjects";

  // Filter options for dropdowns
  final List<String> _subjectOptions = ["All Subjects", "Math", "English", "Science"];

  // Methods to add activities
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

  void _showAddScheduleModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AddScheduleModal(
          onSaveClass: _addNewClass,
          onSaveExam: _addNewExam,
          onSaveTask: _addNewTask,
          onSaveEvent: _addNewEvent,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Add the custom dynamic app bar
      backgroundColor: const Color(0xFFFFF8E8),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            // Tabs for Classes, Exams, Tasks, Events
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
            Expanded(
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showAddScheduleModal(context);
        },
      ),
    );
  }

  Widget _buildClassesTab() {
    return Column(
      children: [
        _buildSubjectDropdown(),
        Expanded(
          child: _classes.isEmpty
              ? const Center(
                  child: Text("No Classes.", style: TextStyle(color: Colors.green, fontSize: 16)),
                )
              : ListView.builder(
                  itemCount: _classes.length,
                  itemBuilder: (context, index) {
                    final classItem = _classes[index];
                    return _buildActivityCard(
                      title: classItem['subject'] ?? "",
                      subtitle: "Room: ${classItem['room']}, Building: ${classItem['building']}\n"
                          "Time: ${classItem['startTime']} - ${classItem['endTime']}",
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildExamsTab() {
    return Column(
      children: [
        _buildSubjectDropdown(),
        Expanded(
          child: _exams.isEmpty
              ? const Center(
                  child: Text("No Exams.", style: TextStyle(color: Colors.green, fontSize: 16)),
                )
              : ListView.builder(
                  itemCount: _exams.length,
                  itemBuilder: (context, index) {
                    final examItem = _exams[index];
                    return _buildActivityCard(
                      title: examItem['subject'] ?? "",
                      subtitle: "Module: ${examItem['module']}\n"
                          "Date: ${examItem['date']}, Time: ${examItem['time']}\n"
                          "Duration: ${examItem['duration']} minutes",
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTasksTab() {
    return Column(
      children: [
        _buildSubjectDropdown(),
        Expanded(
          child: _tasks.isEmpty
              ? const Center(
                  child: Text("No Tasks.", style: TextStyle(color: Colors.green, fontSize: 16)),
                )
              : ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final taskItem = _tasks[index];
                    return _buildActivityCard(
                      title: taskItem['title'] ?? "",
                      subtitle: "Priority: ${taskItem['priority']}\n"
                          "Due Date: ${taskItem['date']} ${taskItem['time']}",
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEventsTab() {
    return Column(
      children: [
        _buildSubjectDropdown(),
        Expanded(
          child: _events.isEmpty
              ? const Center(
                  child: Text("No Events.", style: TextStyle(color: Colors.green, fontSize: 16)),
                )
              : ListView.builder(
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    final eventItem = _events[index];
                    return _buildActivityCard(
                      title: eventItem['name'] ?? "",
                      subtitle: "Start Date: ${eventItem['startDate']}\n"
                          "End Date: ${eventItem['endDate']}",
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSubjectDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedSubject,
        items: _subjectOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedSubject = value!;
          });
        },
        decoration: InputDecoration(
          labelText: 'All Subjects',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Widget _buildActivityCard({required String title, required String subtitle}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
