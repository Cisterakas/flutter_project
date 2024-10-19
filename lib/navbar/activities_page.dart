import 'package:flutter/material.dart';
import 'package:flutter_project/appbar/custom_app_bar.dart'; // Import the custom AppBar

class ActivitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),  // Apply the custom AppBar here
      body: Center(
        child: Text('Activities Page Content'),
      ),
    );
  }
}