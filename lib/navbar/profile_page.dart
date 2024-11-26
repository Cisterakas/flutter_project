import 'package:flutter/material.dart';
import 'package:flutter_project/appbar/custom_app_bar.dart';
import 'package:flutter_project/opening/front_page.dart'; // Import your front page

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Custom app bar
      backgroundColor: const Color(0xFFFFF8E8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade300,
              child: const Text(
                'Profile Picture',
                style: TextStyle(color: Colors.black54, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Name and Email
            const Text(
              "CHLOE ANGELA CRAUSOS",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF718635),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Text(
              "ccrausos@uic.edu.ph",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Statistics Cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildStatCard(
                    title: "Pending Tasks",
                    subtitle: "Next 7 days",
                    value: "2 / 5",
                    color: Colors.green.shade200,
                  ),
                  _buildStatCard(
                    title: "Overdue Tasks",
                    subtitle: "Total",
                    value: "2",
                    color: Colors.green.shade200,
                    isOverdue: true,
                  ),
                  _buildStatCard(
                    title: "Tasks Completed",
                    subtitle: "Last 7 days",
                    value: "3",
                    color: Colors.green.shade200,
                  ),
                  _buildStatCard(
                    title: "My Streak",
                    subtitle: "Day with no tasks going late",
                    value: "3",
                    color: Colors.green.shade200,
                  ),
                ],
              ),
            ),

            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate back to the front page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const FrontPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String subtitle,
    required String value,
    required Color color,
    bool isOverdue = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the content
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 36, // Larger font size for value
              fontWeight: FontWeight.bold,
              color: isOverdue ? Colors.red : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
