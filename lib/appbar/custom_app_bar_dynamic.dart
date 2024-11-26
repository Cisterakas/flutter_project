import 'package:flutter/material.dart';
import 'package:flutter_project/title_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CustomAppBarDynamic extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBarDynamic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current title from the provider
    final title = ref.watch(titleProvider);

    return AppBar(
      automaticallyImplyLeading: false,  // Removes default back arrow if not needed
      backgroundColor: Colors.white,  // Set the AppBar background color to white
      elevation: 0,  // Remove shadow under the AppBar
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Align widgets at opposite ends
        children: [
          // Display the dynamic title
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF718635), // Green color for the title
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Display the logo
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
