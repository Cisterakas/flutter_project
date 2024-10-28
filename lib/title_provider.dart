import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a StateProvider for the title
final titleProvider = StateProvider<String>((ref) => 'Pomodoro Timer'); // Default title
