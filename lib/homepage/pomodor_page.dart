import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_project/appbar/custom_app_bar_dynamic.dart';
import 'package:flutter_project/pomodoro/settings_page.dart';
import 'package:flutter_project/title_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PomodoroPage extends ConsumerStatefulWidget {
  @override
  _PomodoroPageState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends ConsumerState<PomodoroPage> {
  final CountDownController _controller = CountDownController();
  bool isRunning = false;
  int focusTime = 60;

  @override
  void initState() {
    super.initState();
    // Set the title for PomodoroPage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(titleProvider.notifier).state = 'Pomodoro Timer';
    });
  }

  void updateFocusTime(int newFocusTime) {
    setState(() {
      focusTime = newFocusTime;
    });
    _controller.restart(duration: focusTime * 60);
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
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(focusTime: focusTime),
                  ),
                );
                if (result != null) {
                  updateFocusTime(result);
                }
                // Reset title after returning from SettingsPage
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
                  backgroundColor: Color(0xfffff8e8),
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
                SizedBox(height: 20),
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
                    SizedBox(width: 20),
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'While your focus mode is on, all of your notifications will be off',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'lib/assets/pomodoro_icon.png',
                  width: 120,
                  height: 120,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
