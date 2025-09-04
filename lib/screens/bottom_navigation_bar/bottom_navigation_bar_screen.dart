// Main Navigation Widget
import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';
import '../profile_section/profile_screen/profile_screen.dart';
import '../upload_document/upload_document_screen.dart';

class SwipeableBottomNavigation extends StatefulWidget {
  @override
  _SwipeableBottomNavigationState createState() => _SwipeableBottomNavigationState();
}

class _SwipeableBottomNavigationState extends State<SwipeableBottomNavigation> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ Column(
          children: [
            // Main content area with PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  // Home Page - Your existing HomeScreen content
                  HomeScreen(),
        
                  // Upload Document Page
                  UploadDocumentScreen(),
        
                  // Profile Page
                  ProfileScreen(),
                ],
              ),
            ),
        
            // Custom Bottom Navigation
            Container(
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
              child: SizedBox(
                width: 250,
                child: Card(
                  color: Colors.white,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                  child: Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(0, Icons.home),
                        _buildNavItem(1, Icons.add),
                        _buildNavItem(2, Icons.person_outline),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        
        
          ],
        ),
        ]
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF48B14C) : Colors.grey[300],
          borderRadius: BorderRadius.circular(22.5),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}