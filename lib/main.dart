import 'package:flutter/material.dart';
import 'opening/front_page.dart' ;// Import the new front page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FrontPage(), // Set the FrontPage as the home page
    );
  }
}
