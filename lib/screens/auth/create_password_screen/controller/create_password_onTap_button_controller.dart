import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class CreateNewPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var isLoading = false.obs;

  late String token; // This will hold the temporary token from the verify step

  @override
  void onInit() {
    super.onInit();
    // Safely get arguments passed from the OTP verification screen
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      // The email is no longer needed here, but we must get the token.
      token = args['token'] ?? '';
    } else {
      token = '';
    }

    // Critical check: If the token is missing, the user cannot proceed.
    if (token.isEmpty) {
      AppSnackBar.error(
        "Verification token is missing. Please restart the process.",
      );
      // Get.offAllNamed(AppRoutes.signInScreen);
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // --- Validators for password fields (unchanged) ---
  String? validatePassword(String? value) {
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
      return "Please confirm your password.";
    }
    if (value != newPasswordController.text) {
      return "Passwords do not match.";
    }
    return null;
  }

  /// --- CORRECTED: On Tap button to save the new password using the token ---
  Future<void> saveNewPassword() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;

      try {
        // The call to the repository is now simpler and more accurate.
        final response = await AuthRepository.resetPassword(
          token: token, // Pass the temporary token for the header
          newPassword: newPasswordController.text,
          confirmPassword: confirmPasswordController.text,
        );

        AppSnackBar.success(response.message);
        Get.offAllNamed(AppRoutes.signInScreen);
      } catch (e) {
        AppSnackBar.error(e.toString());
      } finally {
        if (!isClosed) {
          isLoading.value = false;
        }
      }
    }
  }
}
