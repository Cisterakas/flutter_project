import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,  // Removes default back arrow if not needed
      backgroundColor: Colors.white,  // Set the AppBar background color to white
      elevation: 0,  // Remove shadow under the AppBar
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Align widgets at opposite ends
        children: [
          RichText(
            text: const TextSpan(
              text: 'Hello,\n',
              style: TextStyle(
                color: Color(0xFF718635), // Green color for 'Hello,'
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Chloe Angela',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFA640), // Orange color for the name
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'lib/assets/logo.png', // Update this with the path to your logo
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);  // Adjust the height of the AppBar
}
