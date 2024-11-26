import 'package:flutter/material.dart';
import 'package:flutter_project/appbar/custom_app_bar_dynamic.dart';
import 'package:flutter_project/title_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final int focusTime;
  final int shortBreak;
  final int longBreak;
  final int longBreakInterval;

  const SettingsPage({super.key, 
    required this.focusTime,
    required this.shortBreak,
    required this.longBreak,
    required this.longBreakInterval,
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late int selectedFocusTime;
  late int selectedShortBreak;
  late int selectedLongBreak;
  late int selectedLongBreakInterval;

  @override
  void initState() {
    super.initState();
    selectedFocusTime = widget.focusTime;
    selectedShortBreak = widget.shortBreak;
    selectedLongBreak = widget.longBreak;
    selectedLongBreakInterval = widget.longBreakInterval;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(titleProvider.notifier).state = 'Settings';
    });
  }

  void saveSettings() {
    Navigator.pop(context, {
      'focusTime': selectedFocusTime,
      'shortBreak': selectedShortBreak,
      'longBreak': selectedLongBreak,
      'longBreakInterval': selectedLongBreakInterval,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarDynamic(),
      backgroundColor: const Color(0xfffff8e8),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Timer', style: TextStyle(fontSize: 24, color: Colors.green)),
            buildDropdownTile(
              label: 'Focus time',
              value: selectedFocusTime,
              onChanged: (value) => setState(() => selectedFocusTime = value!),
              options: [15, 25, 30, 45, 60, 90],
            ),
            buildDropdownTile(
              label: 'Short break',
              value: selectedShortBreak,
              onChanged: (value) => setState(() => selectedShortBreak = value!),
              options: [5, 10, 15],
            ),
            buildDropdownTile(
              label: 'Long break',
              value: selectedLongBreak,
              onChanged: (value) => setState(() => selectedLongBreak = value!),
              options: [15, 20, 30],
            ),
            buildDropdownTile(
              label: 'Long break interval',
              value: selectedLongBreakInterval,
              onChanged: (value) => setState(() => selectedLongBreakInterval = value!),
              options: [1, 2, 3, 4],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: saveSettings,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownTile({
    required String label,
    required int value,
    required ValueChanged<int?> onChanged,
    required List<int> options,
  }) {
    return ListTile(
      title: Text(label),
      trailing: DropdownButton<int>(
        value: value,
        onChanged: onChanged,
        items: options
            .map((option) => DropdownMenuItem<int>(
                  value: option,
                  child: Text('$option ${label.contains("interval") ? "intervals" : "min"}'),
                ))
            .toList(),
      ),
    );
  }
}
