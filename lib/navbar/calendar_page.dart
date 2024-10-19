import 'package:flutter/material.dart';
import 'package:flutter_project/appbar/custom_app_bar.dart'; // Assuming you already created the custom app bar

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),  // Use the custom AppBar
       body: Center(
        child: Text('Calendar Page Content'),
      ),
    );
  }
}
