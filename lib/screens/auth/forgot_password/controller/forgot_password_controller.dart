import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

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

  /// onTap button to send verification code
  Future<void> sendVerificationCode() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus(); // Dismiss keyboard
      isLoading.value = true;

      try {
        final response = await AuthRepository.forgotPassword(
          email: emailController.text.trim(),
        );
        AppSnackBar.success(response.message);

        // Navigate to the OTP verification screen, passing the email
        Get.toNamed(
          AppRoutes.forgotPassVerifyOtpScreen,
          arguments: {'email': emailController.text.trim()},
        );
      } catch (e) {
        AppSnackBar.error(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }
}
