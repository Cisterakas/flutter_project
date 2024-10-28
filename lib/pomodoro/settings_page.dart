import 'package:flutter/material.dart';
import 'package:flutter_project/appbar/custom_app_bar_dynamic.dart';
import 'package:flutter_project/title_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final int focusTime;

  SettingsPage({required this.focusTime});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  int selectedFocusTime = 60;
  int selectedShortBreak = 5;
  int selectedLongBreak = 20;
  int selectedLongBreakInterval = 2;
  bool alertSound = false;

  @override
  void initState() {
    super.initState();
    selectedFocusTime = widget.focusTime;

    // Set the title for SettingsPage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(titleProvider.notifier).state = 'Settings';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarDynamic(),
      backgroundColor: Color(0xfffff8e8),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.orange[400]),
              onPressed: () {
                Navigator.pop(context, selectedFocusTime);
                // Reset title after going back
                ref.read(titleProvider.notifier).state = 'Pomodoro Timer';
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60), // Space for the back button and title
                Text('Timer', style: TextStyle(fontSize: 24, color: Colors.green)),
                SizedBox(height: 10),
                // Focus Time Dropdown
                buildDropdownTile(
                  label: 'Focus time',
                  value: '$selectedFocusTime min',
                  onChanged: (value) {
                    setState(() {
                      selectedFocusTime = value!;
                    });
                  },
                  options: [15, 25, 30, 45, 60, 90],
                ),
                buildDropdownTile(
                  label: 'Short break',
                  value: '$selectedShortBreak min',
                  onChanged: (value) {
                    setState(() {
                      selectedShortBreak = value!;
                    });
                  },
                  options: [5, 10, 15],
                ),
                buildDropdownTile(
                  label: 'Long break',
                  value: '$selectedLongBreak min',
                  onChanged: (value) {
                    setState(() {
                      selectedLongBreak = value!;
                    });
                  },
                  options: [15, 20, 30],
                ),
                buildDropdownTile(
                  label: 'Long break interval',
                  value: '$selectedLongBreakInterval intervals',
                  onChanged: (value) {
                    setState(() {
                      selectedLongBreakInterval = value!;
                    });
                  },
                  options: [1, 2, 3, 4],
                ),
                SizedBox(height: 10),
                Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.green)),
                SizedBox(height: 10),
                SwitchListTile(
                  title: Text('Alert Sound'),
                  value: alertSound,
                  onChanged: (bool value) {
                    setState(() {
                      alertSound = value;
                    });
                  },
                ),
              ],
            ),
          ),
          // Back button in the top left corner
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.orange[400]),
              onPressed: () {
                Navigator.pop(context, selectedFocusTime); // Return updated focus time
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create a dropdown tile
  Widget buildDropdownTile({
    required String label,
    required String value,
    required ValueChanged<int?> onChanged,
    required List<int> options,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(label),
        trailing: DropdownButton<int>(
          value: int.tryParse(value.split(' ').first),
          onChanged: onChanged,
          items: options.map((int option) {
            return DropdownMenuItem<int>(
              value: option,
              child: Text('$option ${label.contains("interval") ? "intervals" : "min"}'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
