import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class CreateNewPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  var isLoading = false.obs;

  late String token;

  @override
  void onInit() {
    super.onInit();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      token = args['token'] ?? '';
    } else {
      token = '';
    }

    if (token.isEmpty) {
      AppSnackBar.error(
        "Verification token is missing. Please restart the process.",
      );
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

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

  Future<void> saveNewPassword() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;

      try {
        final response = await AuthRepository.resetPassword(
          token: token,
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
