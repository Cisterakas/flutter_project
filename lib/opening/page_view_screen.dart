import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_project/navbar/navbar.dart'; // Import NavBar for final navigation

class PageViewScreen extends StatefulWidget {
  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                // User swiped Left
                if (_currentPage < 2) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              } else if (details.primaryVelocity! > 0) {
                // User swiped Right
                if (_currentPage > 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }
            },
            child: PageView(
              controller: _pageController,
              children: [
                _buildPage(
                  color: Color(0xfffff8e8),
                  text: 'Page 1: Introduction',
                  imagePath: 'lib/assets/1st_icon.png',
                  pageIndex: 0,
                ),
                _buildPage(
                  color: Color(0xfffff8e8),
                  text: 'Page 2: Features',
                  imagePath: 'lib/assets/2nd_icon.png',
                  pageIndex: 1,
                ),
                _buildPage(
                  color: Color(0xfffff8e8),
                  text: 'Page 3: Get Started',
                  imagePath: 'lib/assets/3rd_icon.png',
                  pageIndex: 2,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,  // PageController
                  count: 3,  // Number of pages
                  effect: WormEffect(
                    dotColor: Colors.grey,  // Inactive dot color
                    activeDotColor: Color.fromARGB(255, 240, 154, 41),  // Active dot color
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Welcome to MyPath Student Planner",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _currentPage == 0
                        ? "Welcome! You're on the path to success—let's organize your schedule and make studying enjoyable!"
                        : _currentPage == 1
                            ? "Explore effective study techniques that will enhance your learning and boost your productivity!"
                            : "Celebrate your achievements and track your progress as you reach your academic goals!",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,  // Center the paragraph
                  ),
                ),
                SizedBox(height: 16),
                Visibility(
                  visible: _currentPage == 2,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the main NavBar after completing the onboarding pages
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NavBar()),
                      );
                    },
                    child: Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({required Color color, required String text, required int pageIndex, required String imagePath}) {
    return GestureDetector(
      onTap: () {
        if (pageIndex < 2) {
          _pageController.animateToPage(
            pageIndex + 1,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 350,
              height: 195,
              fit: BoxFit.contain, // Ensure the image scales correctly
            ),
            SizedBox(height: 30),
            Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 46, 45, 45),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
