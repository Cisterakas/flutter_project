import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a combined Settings class that extends StateNotifier
class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier()
      : super(Settings(
          focusTime: 25,
          shortBreak: 5,
          longBreak: 20,
          longBreakInterval: 2,
          alertSound: false,
        ));

  void updateFocusTime(int focusTime) {
    state = state.copyWith(focusTime: focusTime);
  }

  void updateShortBreak(int shortBreak) {
    state = state.copyWith(shortBreak: shortBreak);
  }

  void updateLongBreak(int longBreak) {
    state = state.copyWith(longBreak: longBreak);
  }

  void updateLongBreakInterval(int longBreakInterval) {
    state = state.copyWith(longBreakInterval: longBreakInterval);
  }

  void updateAlertSound(bool alertSound) {
    state = state.copyWith(alertSound: alertSound);
  }
}

// Define the Settings class with copyWith method
class Settings {
  final int focusTime;
  final int shortBreak;
  final int longBreak;
  final int longBreakInterval;
  final bool alertSound;

  Settings({
    required this.focusTime,
    required this.shortBreak,
    required this.longBreak,
    required this.longBreakInterval,
    required this.alertSound,
  });

  // Method to create a new Settings instance with updated values
  Settings copyWith({
    int? focusTime,
    int? shortBreak,
    int? longBreak,
    int? longBreakInterval,
    bool? alertSound,
  }) {
    return Settings(
      focusTime: focusTime ?? this.focusTime,
      shortBreak: shortBreak ?? this.shortBreak,
      longBreak: longBreak ?? this.longBreak,
      longBreakInterval: longBreakInterval ?? this.longBreakInterval,
      alertSound: alertSound ?? this.alertSound,
    );
  }
}

// Create a provider for the SettingsNotifier
final settingsProvider = StateNotifierProvider<SettingsNotifier, Settings>(
  (ref) => SettingsNotifier(),
);
