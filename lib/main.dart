import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'opening/front_page.dart'; // Import the new front page

void main() {
  runApp(const ProviderScope(child: MyApp())); // Wrap MyApp with ProviderScope
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      home: FrontPage(), // Set the FrontPage as the home page
    );
  }
}
