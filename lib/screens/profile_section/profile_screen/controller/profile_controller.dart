import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/app_image_path.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import 'package:sierrahilbun/services/repository/profile_repository/profile_repository.dart';
import 'package:sierrahilbun/services/storage/storage_service.dart';
import 'package:sierrahilbun/utils/app_log/app_log.dart';
import 'package:sierrahilbun/widgets/app_button/app_button.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:sierrahilbun/widgets/showCustomDialog.dart';
import 'package:sierrahilbun/widgets/text_field_widget/text_field_widget.dart';

class ProfileController extends GetxController {
  var userName = ''.obs;
  var userImageUrl = ''.obs;
  var userEmail = ''.obs;
  var userContact = ''.obs;
  var isLoading = false.obs;
  // Controller for the password confirmation dialog
  late TextEditingController passwordConfirmController;

  @override
  void onInit() {
    super.onInit();
    // Load the user's data when the controller is first created
    loadUserData();
    passwordConfirmController = TextEditingController();
  }

  @override
  void onClose() {
    passwordConfirmController.dispose();
    super.onClose();
  }

  void loadUserData() {
    // This will get the latest data, even if it was just updated.
    userName.value = LocalStorage.myName;
    userImageUrl.value = LocalStorage.myImage;
    userEmail.value = LocalStorage.myEmail;
    userContact.value = LocalStorage.myContact;
    print("LocalStorage.myName is: ${LocalStorage.myName}");
    print("LocalStorage.myImage is: ${LocalStorage.myImage}");
    print("LocalStorage.myEmail is: ${LocalStorage.myEmail}");
    print("LocalStorage.myContact is: ${LocalStorage.myContact}");
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

  void deleteAccount() {
    // Clear any previous text before showing the dialog
    passwordConfirmController.clear();

    // Show the custom dialog that asks for a password
    Get.dialog(
      ShowCustomDialog(
        title: 'Delete Account?',
        description:
            'Please confirm your password to permanently remove your account.',
        image: Image.asset(AppImagePath.deleteBox),
        actionsLayout: ActionsLayout.column, // Use column for text field
        actions: [
          TextFieldWidget(
            borderRadius: 12,
            controller: passwordConfirmController,
            hintText: 'Enter your password',
            suffixIcon: true, // For obscuring text
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Center(child: Text("Cancel")),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Delete Button
              Expanded(
                child: Obx(() {
                  return isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.red),
                        )
                      : GestureDetector(
                          onTap:
                              _confirmDeleteWithPassword, // Call the method that verifies password
                          child: const AppButton(
                            filColor: Colors.red,
                            title: "Delete",
                          ),
                        );
                }),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  /// --- NEW: Private method to verify password and then delete account ---
  Future<void> _confirmDeleteWithPassword() async {
    final String password = passwordConfirmController.text;
    if (password.isEmpty) {
      AppSnackBar.message("Please enter your password.");
      return;
    }

    isLoading.value = true;
    try {
      // STEP 1: Verify the password is correct.
      final bool isPasswordCorrect = await AuthRepository.verifyPassword(
        password: password,
      );

      if (isPasswordCorrect) {
        // STEP 2: If password is correct, proceed to delete the account.
        final response = await ProfileRepository.deleteAccount();
        AppSnackBar.success(response.message);
        await logout(); // Perform full logout and navigation
      } else {
        // If password is wrong, show an error.
        throw Exception("Incorrect password. Please try again.");
      }
    } catch (e) {
      // If there's an error, close the dialog and show a message.
      Get.back();
      AppSnackBar.error(e.toString());
    } finally {
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }
}
