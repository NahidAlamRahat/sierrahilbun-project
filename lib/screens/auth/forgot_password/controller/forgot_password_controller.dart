import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordOnTapButtonController extends GetxController {
  final emailController = TextEditingController();
  // final ForgotPasswordRepository _forgotPasswordRepository =
  // Get.put(ForgotPasswordRepository());

 /* @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }*/


  // Validate Email
  String? validateEmail(String? value) {
    bool emailValid =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value ?? "");
    if (value == null || value.isEmpty) {
      return "Enter Email";
    } else if (!emailValid) {
      return "Enter a valid Email";
    }
    return null;
  }


/// on Tap button

/*  Future<void> onTapSentEmailButton() async {

    if (emailController.text.isNotEmpty) {
      final bool isSuccess = await _forgotPasswordRepository
          .forgotPasswordApiCall(email: emailController.text.trim());

      _forgotPasswordRepository.inProgress == true;

      if (isSuccess) {
        _forgotPasswordRepository.inProgress == false;

        AppSnackBar.success(_forgotPasswordRepository.successfullyMessage ??
            'Login Successful!');
        appLog('success message => ${_forgotPasswordRepository.errorMessage}');
        Get.toNamed(
          AppRoutes.userForgotVerifyOtpScreen,
          arguments: {'email': emailController.text},
        );
      } else {
        _forgotPasswordRepository.inProgress == false;
        // error message
        AppSnackBar.message('${_forgotPasswordRepository.errorMessage}');
        appLog(
            'error message => ${_forgotPasswordRepository.errorMessage}');
      }
    } else {
      AppSnackBar.error("Please enter your email.");
    }
  }*/
}
