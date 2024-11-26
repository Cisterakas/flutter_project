import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_project/appbar/custom_app_bar_dynamic.dart';
import 'package:flutter_project/pomodoro/settings_page.dart';
import 'package:flutter_project/title_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PomodoroPage extends ConsumerStatefulWidget {
  const PomodoroPage({super.key});

  @override
  _PomodoroPageState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends ConsumerState<PomodoroPage> {
  final CountDownController _controller = CountDownController();
  bool isRunning = false;

  // Default Timer Settings
  int focusTime = 25;
  int shortBreak = 5;
  int longBreak = 20;
  int longBreakInterval = 2;

  @override
  void initState() {
    super.initState();
    // Set the title for PomodoroPage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(titleProvider.notifier).state = 'Pomodoro Timer';
    });
  }

  void updateSettings({
    required int newFocusTime,
    required int newShortBreak,
    required int newLongBreak,
    required int newLongBreakInterval,
  }) {
    setState(() {
      focusTime = newFocusTime;
      shortBreak = newShortBreak;
      longBreak = newLongBreak;
      longBreakInterval = newLongBreakInterval;
    });
    _controller.restart(duration: focusTime * 60); // Restart with updated focus time
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarDynamic(),
      backgroundColor: const Color(0xfffff8e8),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.orange[400]),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.orange[400]),
              onPressed: () async {
                final settings = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      focusTime: focusTime,
                      shortBreak: shortBreak,
                      longBreak: longBreak,
                      longBreakInterval: longBreakInterval,
                    ),
                  ),
                );
                if (settings != null) {
                  updateSettings(
                    newFocusTime: settings['focusTime'],
                    newShortBreak: settings['shortBreak'],
                    newLongBreak: settings['longBreak'],
                    newLongBreakInterval: settings['longBreakInterval'],
                  );
                }
                ref.read(titleProvider.notifier).state = 'Pomodoro Timer';
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularCountDownTimer(
                  duration: focusTime * 60,
                  initialDuration: 0,
                  controller: _controller,
                  width: 200.0,
                  height: 200.0,
                  ringColor: Colors.grey[300]!,
                  fillColor: Colors.orange[400]!,
                  backgroundColor: const Color(0xfffff8e8),
                  strokeWidth: 10.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                    fontSize: 40.0,
                    color: Colors.orange[400],
                    fontWeight: FontWeight.bold,
                  ),
                  isReverse: true,
                  onComplete: () {
                    setState(() {
                      isRunning = false;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        isRunning ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        size: 50,
                        color: Colors.orange[400],
                      ),
                      onPressed: () {
                        setState(() {
                          if (isRunning) {
                            _controller.pause();
                          } else {
                            _controller.resume();
                          }
                          isRunning = !isRunning;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: Icon(
                        Icons.restart_alt,
                        size: 50,
                        color: Colors.orange[400],
                      ),
                      onPressed: () {
                        _controller.restart();
                        setState(() {
                          isRunning = true;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'While your focus mode is on, all of your notifications will be off',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'lib/assets/pomodoro_icon.png',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
