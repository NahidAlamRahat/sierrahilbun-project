import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen/home_screen.dart';
import '../profile_section/profile_screen/profile_screen.dart';
import '../upload_document/upload_document_screen.dart';
import 'controller/bottom_nav_controller.dart';

class SwipeableBottomNavigation extends StatelessWidget {
  const SwipeableBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              // Main content area with PageView
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  children: [
                    HomeScreen(),
                    UploadDocumentScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),

              // Custom Bottom Navigation
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 250,
                  child: Card(
                    color: Colors.white,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNavItem(controller, 0, Icons.home),
                          _buildNavItem(controller, 1, Icons.add),
                          _buildNavItem(controller, 2, Icons.person_outline),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BottomNavController controller, int index, IconData icon) {
    bool isSelected = controller.currentIndex == index;

    return GestureDetector(
      onTap: () => controller.onTabTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF48B14C) : Colors.grey[300],
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
