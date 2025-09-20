import 'dart:async';

import 'package:get/get.dart';
import 'package:sierrahilbun/services/storage/storage_service.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../utils/app_log/app_log.dart';

class SplashController extends GetxController {
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    appLog("SplashController initialized");
    _decideNextRoute();
  }

  /// Determines the next screen based on the user's login status.
  Future<void> _decideNextRoute() async {
    // Let the splash screen animations run for a few seconds.
    await Future.delayed(const Duration(seconds: 4));

    try {
      // Load all saved data from your detailed LocalStorage service.
      await LocalStorage.getAllPrefData();

      // Check if the access token exists and is not an empty string.
      // Your getAllPrefData() method populates the static LocalStorage.token variable.
      if (LocalStorage.token.isNotEmpty) {
        // If token exists, user is logged in. Go to the home screen.
        appLog("User is logged in. Navigating to home screen.");
        Get.offAllNamed(
          AppRoutes.swipeableBottomNavigation,
        ); // Change this to your actual home screen route if different
      } else {
        // If no token, user needs to log in. Go to the sign-in screen.
        appLog("User is not logged in. Navigating to sign-in screen.");
        Get.offAllNamed(AppRoutes.signInScreen);
      }
    } catch (e) {
      appLog(
        "Error deciding route: $e. Navigating to sign-in screen as a fallback.",
      );
      // In case of any error during data loading, it's safest to send the user to the login page.
      Get.offAllNamed(AppRoutes.signInScreen);
    }
  }

  @override
  void onClose() {
    appLog("SplashController disposed");
    super.onClose();
  }
}
