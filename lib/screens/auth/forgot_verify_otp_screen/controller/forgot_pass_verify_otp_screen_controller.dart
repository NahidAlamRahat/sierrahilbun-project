import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class ForgotPassVerifyOtpScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController otpTextEditingController;

  var remainingSeconds = 180.obs;
  var canResend = false.obs;
  var isLoading = false.obs;

  late String email;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    otpTextEditingController = TextEditingController();
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args.containsKey('email')) {
      email = args['email'];
    } else {
      email = '';
      AppSnackBar.error("Error: Email not found.");
    }
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpTextEditingController.dispose();
    super.onClose();
  }

  void startTimer() {
    _timer?.cancel();
    canResend.value = false;
    remainingSeconds.value = 180;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  String formatTime() {
    final minutes = remainingSeconds.value ~/ 60;
    final remainingSec = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSec.toString().padLeft(2, '0')}';
  }

  void resendCode() async {
    if (email.isEmpty) return;
    isLoading.value = true;
    try {
      final response = await AuthRepository.forgotPassword(email: email);
      AppSnackBar.success(response.message);
      startTimer();
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }

  Future<void> onTapVerifyButton() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;

      try {
        final response = await AuthRepository.verifyOtp(
          email: email,
          otp: otpTextEditingController.text,
        );
        AppSnackBar.success(response.message);

        Get.toNamed(
          AppRoutes.createNewPasswordScreen,
          arguments: {'token': response.data ?? ''},
        );
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
