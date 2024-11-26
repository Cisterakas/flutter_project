import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddScheduleModal extends StatelessWidget {
  final Function(Map<String, String>) onSaveClass;
  final Function(Map<String, String>) onSaveExam;
  final Function(Map<String, String>) onSaveTask;
  final Function(Map<String, String>) onSaveEvent;
  final DateTime? selectedDate;

  const AddScheduleModal({
    required this.onSaveClass,
    required this.onSaveExam,
    required this.onSaveTask,
    required this.onSaveEvent,
    this.selectedDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            length: 4,
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
                      _buildAddClassForm(context, controller),
                      _buildAddExamForm(context, controller),
                      _buildAddTaskForm(context, controller),
                      _buildAddEventForm(context, controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddClassForm(BuildContext context, ScrollController controller) {
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
            const Text(
              "Add New Class",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(labelText: "Subject Name"),
            ),
            TextField(
              controller: teacherController,
              decoration: const InputDecoration(labelText: "Teacher Name"),
            ),
            TextField(
              controller: roomController,
              decoration: const InputDecoration(labelText: "Room"),
            ),
            TextField(
              controller: buildingController,
              decoration: const InputDecoration(labelText: "Building"),
            ),
            TextField(
              controller: startTimeController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Start Time"),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  startTimeController.text = picked.format(context);
                }
              },
            ),
            TextField(
              controller: endTimeController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "End Time"),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  endTimeController.text = picked.format(context);
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                onSaveClass({
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

  Widget _buildAddExamForm(BuildContext context, ScrollController controller) {
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
            const Text(
              "Add New Exam",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(labelText: "Subject Name"),
            ),
            TextField(
              controller: moduleController,
              decoration: const InputDecoration(labelText: "Module"),
            ),
            TextField(
              controller: roomController,
              decoration: const InputDecoration(labelText: "Room"),
            ),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Date"),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  dateController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                }
              },
            ),
            TextField(
              controller: timeController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Time"),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  timeController.text = pickedTime.format(context);
                }
              },
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(labelText: "Duration (minutes)"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                onSaveExam({
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

  Widget _buildAddTaskForm(BuildContext context, ScrollController controller) {
    final TextEditingController taskTitleController = TextEditingController();
    final TextEditingController taskDescriptionController =
        TextEditingController();
    final TextEditingController taskDateController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add New Task",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: taskTitleController,
              decoration: const InputDecoration(labelText: "Task Title"),
            ),
            TextField(
              controller: taskDescriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 2,
            ),
            TextField(
              controller: taskDateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Due Date"),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  taskDateController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                onSaveTask({
                  'title': taskTitleController.text,
                  'description': taskDescriptionController.text,
                  'dueDate': taskDateController.text,
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

  Widget _buildAddEventForm(BuildContext context, ScrollController controller) {
    final TextEditingController eventNameController = TextEditingController();
    final TextEditingController eventDescriptionController =
        TextEditingController();
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add New Event",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: eventNameController,
              decoration: const InputDecoration(labelText: "Event Name"),
            ),
            TextField(
              controller: eventDescriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 2,
            ),
            TextField(
              controller: startDateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Start Date"),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  startDateController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                }
              },
            ),
            TextField(
              controller: endDateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "End Date"),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  endDateController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                onSaveEvent({
                  'name': eventNameController.text,
                  'description': eventDescriptionController.text,
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
}
