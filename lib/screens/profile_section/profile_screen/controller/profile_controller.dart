import 'package:get/get.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/storage/storage_service.dart';
import 'package:sierrahilbun/utils/app_log/app_log.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class ProfileController extends GetxController {
  var userName = ''.obs;
  var userImageUrl = ''.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the user's data when the controller is first created
    loadUserData();
  }

  void loadUserData() {
    // This will get the latest data, even if it was just updated.
    userName.value = LocalStorage.myName;
    userImageUrl.value = LocalStorage.myImage;
    userEmail.value = LocalStorage.myEmail;
  }

  /// Handles the complete logout process.
  Future<void> logout() async {
    try {
      // 1. Clear all user data (tokens, name, email, etc.) from SharedPreferences.
      await LocalStorage.removeAllPrefData();
      appLog("User data cleared from local storage.");

      // 2. Navigate to the sign-in screen and remove all previous routes from the stack.
      // This is crucial to prevent the user from pressing the back button to a logged-in screen.
      Get.offAllNamed(AppRoutes.signInScreen);
    } catch (e) {
      appLog("Error during logout: $e", source: "ProfileController");
      // Show an error if something goes wrong during the logout process.
      AppSnackBar.error("Could not log out. Please try again.");
    }
  }
}
