import 'dart:async';

import 'package:get/get.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../utils/app_log/app_log.dart';

class SplashController extends GetxController {
  // Loading state for UI feedback
  final RxBool isLoading = true.obs;

  // Timer reference for cleanup
  Timer? _navigationTimer;

  @override
  void onInit() {
    super.onInit();
    appLog("SplashController initialized");
    _initializeSplashFlow();
  }

  void _initializeSplashFlow() async {
    try {
      // Optional: Add any initialization logic here
      // e.g., check authentication, load essential data, etc.
      await _performInitialChecks();

      // Navigate after 3 seconds
      _scheduleNavigation();

    } catch (e) {
      appLog("Error during splash initialization: $e");
      // Even if there's an error, still navigate after delay
      _scheduleNavigation();
    }
  }

  Future<void> _performInitialChecks() async {
    // Add any initialization logic here:
    // - Check if user is already logged in
    // - Load app configuration
    // - Initialize services
    // - Check app updates

    // Example placeholder for initialization
    await Future.delayed(const Duration(milliseconds: 500));
    appLog("Initial checks completed");
  }

  void _scheduleNavigation() {
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      _navigateToNextScreen();
    });
  }

  void _navigateToNextScreen() {
    if (!Get.isRegistered<SplashController>()) {
      // Controller already disposed, don't navigate
      return;
    }

    try {
      isLoading.value = false;
      appLog("Navigating to SignIn screen");

      // Clear all previous routes and go to sign in
      Get.offAllNamed(AppRoutes.signInScreen);

    } catch (e) {
      appLog("Error during navigation: $e");
    }
  }

  // Method to skip splash manually (if needed)
  void skipSplash() {
    _navigationTimer?.cancel();
    _navigateToNextScreen();
  }

  @override
  void onClose() {
    // Clean up timer to prevent memory leaks
    _navigationTimer?.cancel();
    appLog("SplashController disposed");
    super.onClose();
  }
}