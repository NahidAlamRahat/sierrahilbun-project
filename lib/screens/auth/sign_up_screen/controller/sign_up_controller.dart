import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

import '../../../../utils/app_log/app_log.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text Field Controllers
  late TextEditingController nameController ;
  late TextEditingController emailController ;
  late TextEditingController phoneController ;
  late TextEditingController passwordController ;
  late TextEditingController confirmPasswordController ;

  // --- State variables are now reactive (.obs) for better UI updates ---
  var isChecked = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  // Toggle checkbox
  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  // ✅ Validators (no changes needed here)
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter Full Name";
    } else if (value.trim().length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }

  String? validateEmail(String? value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value ?? "");
    if (value == null || value.isEmpty) {
      return "Enter Email";
    } else if (!emailValid) {
      return "Enter a valid Email";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Phone Number";
    }
    // Updated regex to be more flexible for international numbers
    else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return "Enter a valid Phone Number";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm your password";
    } else if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  /// --- FULLY IMPLEMENTED SIGNUP LOGIC ---
  Future<void> onTapSignUpButton() async {
    // 1. Check if terms are accepted
    if (!isChecked.value) {
      AppSnackBar.message("Please agree to the Terms & Conditions and Privacy Policy.");
      return;
    }

    // 2. Validate the form fields
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        // 3. Call the repository to perform the signup
        final response = await AuthRepository.signUp(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          contact: phoneController.text.trim(),
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );

        // 4. Handle successful registration
        appLog("✅ SignUp Successful: ${response.message}");
        AppSnackBar.success(response.message);

        // Navigate to the OTP verification screen with the user's email
        Get.toNamed(
          AppRoutes.createPassVerifyOtpScreen,
          arguments: {'email': emailController.text.trim()},
        );

      } catch (e) {
        // 5. Handle errors by showing a snackbar
        AppSnackBar.message(e.toString());
        appLog("❌ SignUp Failed: $e");
      } finally {
        // 6. Always turn off the loader
        isLoading.value = false;
      }
    }
  }

  @override
  void dispose() {
    // Dispose all text controllers to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}