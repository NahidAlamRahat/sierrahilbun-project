import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/api_urls.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/auth_repository/auth_repository.dart';
import 'package:sierrahilbun/services/storage/storage_key.dart';
import 'package:sierrahilbun/services/storage/storage_service.dart';
import 'package:sierrahilbun/utils/app_log/app_log.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class SignInController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  // --- UPDATED SECTION ---
  // Observable variables for UI state management.
  // .obs makes them reactive, so the UI updates automatically.
  var isLoading = false.obs;

  // Removed errorMessage since we'll use GetX snackbar
  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

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
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;

      try {
        // --- STEP 1: Log in to get the tokens ---
        final loginResponse = await AuthRepository.login(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        // Save tokens to LocalStorage immediately so the next API call is authenticated.
        await LocalStorage.setString(
          LocalStorageKeys.token,
          loginResponse.data.accessToken,
        );
        await LocalStorage.setString(
          LocalStorageKeys.refreshToken,
          loginResponse.data.refreshToken,
        );
        // Also update the static variable for immediate use
        LocalStorage.token = loginResponse.data.accessToken;

        // --- STEP 2: Fetch the full user profile ---
        final profileResponse = await AuthRepository.getUserProfile();

        if (profileResponse.success && profileResponse.data != null) {
          final userData = profileResponse.data!;

          // Construct the full image URL
          final String fullImageUrl =
              (userData.profileImage != null &&
                  userData.profileImage!.isNotEmpty)
              ? '${ApiUrls.baseImageUrl}${userData.profileImage}'
              : '';

          // --- STEP 3: Save all user data to LocalStorage ---
          await LocalStorage.setString(LocalStorageKeys.userId, userData.id);
          await LocalStorage.setString(
            LocalStorageKeys.myName,
            userData.name ?? '',
          );
          await LocalStorage.setString(
            LocalStorageKeys.myEmail,
            userData.email,
          );
          await LocalStorage.setString(LocalStorageKeys.myRole, userData.role);
          await LocalStorage.setString(
            LocalStorageKeys.myContact,
            userData.contact ?? '',
          );
          await LocalStorage.setString(
            LocalStorageKeys.myLocation,
            userData.location ?? '',
          );
          await LocalStorage.setString(LocalStorageKeys.myImage, fullImageUrl);
          await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);

          // Update static variables as well for immediate access
          await LocalStorage.getAllPrefData();

          appLog("All user data saved. Navigating to home.");
          Get.offAllNamed(AppRoutes.swipeableBottomNavigation);
        } else {
          throw Exception("Failed to retrieve user profile after login.");
        }
      } catch (e) {
        AppSnackBar.error(e.toString());
        // On failure, ensure the loading indicator is turned off.
        isLoading.value = false;
      }
      // On success, we navigate away, so no need to set isLoading to false.
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
