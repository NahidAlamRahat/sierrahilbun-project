import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BottomNavController extends GetxController {
  // Page controller
  final PageController pageController = PageController();

  // Current selected index
  int currentIndex = 0;

  // Update index on page change
  void onPageChanged(int index) {
    currentIndex = index;
    update();
  }

  // Handle tab tap
  void onTabTapped(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentIndex = index;
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
