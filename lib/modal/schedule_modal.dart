import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting time and date

class ScheduleModal {
  void showScheduleFormModal(BuildContext context) {
    // Default values
    String selectedSubject = 'English';
    String mode = 'In Person';
    String occurrence = 'Once';
    DateTime selectedDate = DateTime.now();
    TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 9, minute: 0);
    String reminderBefore = '5 minutes';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  const Text(
                    'New',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF718635), // Green color
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Tab Bar (Classes, Exams, Tasks, Events)
                  const TabBar(
                    labelColor: Color(0xFFE36C27), // Orange color
                    unselectedLabelColor: Colors.black87,
                    tabs: [
                      Tab(text: "Classes"),
                      Tab(text: "Exams"),
                      Tab(text: "Tasks"),
                      Tab(text: "Events"),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Select Subject Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(selectedSubject),
                        backgroundColor: const Color(0xFFE4B7B7), // Pinkish background
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Logic to add new subject
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFACDB78), // Light green background
                        ),
                        child: const Text('+ Add new'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Mode (In Person, Online)
                  Row(
                    children: [
                      ChoiceChip(
                        label: const Text('In Person'),
                        selected: mode == 'In Person',
                        onSelected: (bool selected) {
                          mode = 'In Person';
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Online'),
                        selected: mode == 'Online',
                        onSelected: (bool selected) {
                          mode = 'Online';
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Room and Building fields
                  const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Room',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Building',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Teacher field
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Teacher',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Occurrence (Once, Repeating)
                  Row(
                    children: [
                      ChoiceChip(
                        label: const Text('Once'),
                        selected: occurrence == 'Once',
                        onSelected: (bool selected) {
                          occurrence = 'Once';
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Repeating'),
                        selected: occurrence == 'Repeating',
                        onSelected: (bool selected) {
                          occurrence = 'Repeating';
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Date Picker
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            selectedDate = picked;
                          }
                        },
                      ),
                    ),
                    controller: TextEditingController(
                      text: DateFormat('EEE, d MMM yyyy').format(selectedDate),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Start Time and End Time
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Start Time',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.access_time),
                              onPressed: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: startTime,
                                );
                                if (picked != null) {
                                  startTime = picked;
                                }
                              },
                            ),
                          ),
                          controller: TextEditingController(
                            text: startTime.format(context),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'End Time',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.access_time),
                              onPressed: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: endTime,
                                );
                                if (picked != null) {
                                  endTime = picked;
                                }
                              },
                            ),
                          ),
                          controller: TextEditingController(
                            text: endTime.format(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Reminder before
                  DropdownButtonFormField<String>(
                    value: reminderBefore,
                    items: <String>['5 minutes', '10 minutes', '30 minutes', '1 hour']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      reminderBefore = newValue!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Remind me before',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Save and Cancel Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Save logic
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9643), // Orange color
                        ),
                        child: const Text('Save'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close modal
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFACDB78), // Green color
                        ),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
