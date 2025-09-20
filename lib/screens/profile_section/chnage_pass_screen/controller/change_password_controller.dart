import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class ChangePasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Using your preferred 'late' initialization pattern
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initializing controllers in onInit as you had
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  // Using your preferred 'dispose' method name
  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // --- Validators for all password fields (Unchanged) ---
  String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your current password.";
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a new password.";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters.";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your new password.";
    }
    if (value != newPasswordController.text) {
      return "Passwords do not match.";
    }
    return null;
  }

  /// --- On Tap button to change the password (with the corrected logic) ---
  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;

      try {
        final response = await AuthRepository.changePassword(
          currentPassword: oldPasswordController.text,
          newPassword: newPasswordController.text,
          confirmPassword: confirmPasswordController.text,
        );

        // --- THE FIX ---
        // 1. First, navigate back. The loading indicator will be destroyed with the screen.
        Get.back();

        // 2. Then, show the snackbar. GetX will display it on the previous screen.
        //    This avoids any race conditions.
        AppSnackBar.success(response.message);
      } catch (e) {
        // If an error occurs, the user stays on the screen.
        // We must hide the loader so they can try again.
        AppSnackBar.error(e.toString());
        isLoading.value = false;
      }
    }
  }
}
