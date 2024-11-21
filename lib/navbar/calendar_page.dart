import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_project/appbar/custom_app_bar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<Map<String, String>>> _tasks = {};

  @override
  void initState() {
    super.initState();
  }

  void _addEvent(DateTime day) {
    showDialog(
      context: context,
      builder: (context) {
        String taskTitle = '';
        String taskTime = '';
        String taskDuration = '';

        return AlertDialog(
          title: Text('Add New Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Task Title'),
                onChanged: (value) {
                  taskTitle = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time (e.g., 10:00 AM)'),
                onChanged: (value) {
                  taskTime = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Duration (e.g., 1 hour)'),
                onChanged: (value) {
                  taskDuration = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskTitle.isNotEmpty && taskTime.isNotEmpty) {
                  setState(() {
                    if (_tasks[day] == null) {
                      _tasks[day] = [];
                    }
                    _tasks[day]!.add({
                      'time': taskTime,
                      'title': taskTitle,
                      'duration': taskDuration,
                      'completed': 'false',
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Color(0xffF6F6E9),
      body: Column(
        children: [
          // Calendar Widget
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _addEvent(selectedDay); // Show dialog when a day is pressed
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) {
              return _tasks[day] ?? [];
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: _tasks[_selectedDay]?.map((task) {
                    return _buildTaskCard(
                      time: task['time'] ?? '',
                      title: task['title'] ?? '',
                      duration: task['duration'] ?? '',
                      completed: task['completed'] == 'true',
                    );
                  }).toList() ??
                  [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'No tasks for the selected day',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _addEvent(_selectedDay); // Show dialog when the add button is pressed
        },
      ),
    );
  }

  Widget _buildTaskCard({
    required String time,
    required String title,
    required String duration,
    required bool completed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (duration.isNotEmpty)
                        Text(
                          duration,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                  if (completed)
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
