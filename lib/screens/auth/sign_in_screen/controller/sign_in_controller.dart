import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import 'package:sierrahilbun/services/storage/storage_key.dart';
import 'package:sierrahilbun/services/storage/storage_service.dart';
import 'package:sierrahilbun/utils/app_log/app_log.dart';

class SignInController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // --- ADDED THIS SECTION ---
  // Observable variables for UI state management.
  // .obs makes them reactive, so the UI updates automatically.
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  // -------------------------

  // Validate Email
  String? validateEmail(String? value) {
    bool emailValid = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(value ?? "");
    if (value == null || value.isEmpty) {
      return "Enter Email";
    } else if (!emailValid) {
      return "Enter a valid Email";
    }
    return null;
  }

  // Validate Password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 8) {
      return "Password length should be more than 8 characters";
    }
    return null;
  }

  /// Handles the sign-in button tap event.
  Future<void> onTapSignInButton() async {
    // First, validate the form.
    if (formKey.currentState!.validate()) {
      // Set loading state to true and clear any previous errors.
      isLoading.value = true;
      errorMessage.value = '';

      try {
        // Call the repository to perform the login.
        final response = await AuthRepository.login(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        // Save tokens using your existing LocalStorage service.
        await LocalStorage.setString(
          LocalStorageKeys.token,
          response.data.accessToken,
        );
        await LocalStorage.setString(
          LocalStorageKeys.refreshToken,
          response.data.refreshToken,
        );
        await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);

        // Refresh the in-memory variables in LocalStorage.
        await LocalStorage.getAllPrefData();

        // Navigate to the home screen on success, removing the login screen from the stack.
        Get.offAllNamed(AppRoutes.swipeableBottomNavigation);
      } catch (e) {
        // If an error occurs, update the errorMessage to display it in the UI.
        errorMessage.value = e.toString().replaceFirst("Exception: ", "");
        debugPrint("Login Error: ${e.toString()}");
      } finally {
        // Always set loading state back to false when the process is complete.
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks when the screen is closed.
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
