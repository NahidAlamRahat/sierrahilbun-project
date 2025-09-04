import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sierrahilbun/routes/app_routes.dart';

import '../../../../utils/app_log/app_log.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? selectedRole;
  bool isChecked = false;
  bool inProgress = false;

  // Toggle checkbox
  void toggleCheckbox() {
    isChecked = !isChecked;
    update();
  }

  // ✅ Validators
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
    } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
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

  Future<void> onTapSignUpButton() async {
    if (formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.createPassVerifyOtpScreen,arguments: {'email': emailController.text.trim()});
      appLog("✅ Form Validated. Ready to send API call.");
      // Call your signup API here
    }
  }
}
