import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import '../../../../../utils/app_log/app_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class CreatePassVerifyOtpScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpTextEditingController =
      TextEditingController();

  // --- Reactive state variables ---
  var remainingSeconds = 10.obs; // 3 minutes
  var canResend = false.obs;
  var isLoading = false.obs; // For loading indicator

  late String email;
  Timer? _timer;
  bool _isDisposed = false;

  @override
  void onInit() {
    super.onInit();
    // Safely get email from arguments passed during navigation
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args.containsKey('email')) {
      email = args['email'];
    } else {
      email = ''; // Fallback if email is not passed
      AppSnackBar.error("Error: Email not found. Please go back.");
    }
    startTimer();
  }

  @override
  void onClose() {
    _isDisposed = true;
    _timer?.cancel(); // Important: cancel the timer to prevent memory leaks

    // Safely dispose the text controller
    try {
      otpTextEditingController.dispose();
    } catch (e) {
      // Controller might already be disposed, ignore the error
    }

    super.onClose();
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    canResend.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }
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

  /// --- FULLY IMPLEMENTED RESEND OTP LOGIC ---
  void resendCode() async {
    if (email.isEmpty || isClosed)
      return; // Don't proceed if email is missing or controller is disposed

    isLoading.value = true;
    try {
      final response = await AuthRepository.resendOtp(email: email);
      if (!isClosed) {
        AppSnackBar.success(response.message);
        remainingSeconds.value = 180; // Reset the timer
        startTimer(); // Restart the timer
      }
    } catch (e) {
      if (!isClosed) {
        AppSnackBar.error(e.toString());
      }
    } finally {
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }

  /// --- FULLY IMPLEMENTED VERIFY OTP LOGIC ---
  Future<void> onTapVerifyButton() async {
    if (_isDisposed || isClosed) return; // Early exit if controller is disposed

    final String otp = otpTextEditingController.text;
    if (otp.length != 6) {
      AppSnackBar.message("Please enter the 6-digit code.");
      return;
    }
    if (email.isEmpty) return;

    isLoading.value = true;
    try {
      final response = await AuthRepository.verifyOtp(email: email, otp: otp);
      if (!_isDisposed && !isClosed) {
        AppSnackBar.success(response.message);
        // Clear the loading state before navigation
        isLoading.value = false;
        // On successful verification, navigate to the next screen
        Get.offAllNamed(AppRoutes.signInScreen);
      }
    } catch (e) {
      if (!_isDisposed && !isClosed) {
        AppSnackBar.error(e.toString());
        isLoading.value = false;
      }
    }
  }
}
