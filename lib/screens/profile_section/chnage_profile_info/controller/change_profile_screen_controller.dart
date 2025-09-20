import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sierrahilbun/constants/api_urls.dart';
import 'package:sierrahilbun/screens/profile_section/profile_screen/controller/profile_controller.dart';
import 'package:sierrahilbun/services/repository/profile_repository/profile_repository.dart';
import 'package:sierrahilbun/services/storage/storage_key.dart';
import 'package:sierrahilbun/services/storage/storage_service.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class ChangeProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  var isLoading = false.obs;
  var selectedImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: LocalStorage.myName);
    phoneController = TextEditingController(text: "01786543210");
    emailController = TextEditingController(text: LocalStorage.myEmail);
    addressController = TextEditingController(text: "Dhaka");
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> pickImageFromGallery() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImagePath.value = image.path;
      }
    } else {
      AppSnackBar.message(
        "Photo access is required to select a profile picture.",
      );
    }
  }

  /// Calls the repository to update the user's profile.
  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;

      try {
        final response = await ProfileRepository.updateProfile(
          name: nameController.text.trim(),
          contact: phoneController.text.trim(),
          location: addressController.text.trim(),
          imagePath: selectedImagePath.value,
        );

        if (response.success && response.data != null) {
          final String relativePath = response.data!.profileImage ?? '';
          final String fullImageUrl = relativePath.isNotEmpty
              ? '${ApiUrls.baseImageUrl}$relativePath'
              : '';

          await LocalStorage.setString(
            LocalStorageKeys.myName,
            response.data!.name,
          );
          await LocalStorage.setString(LocalStorageKeys.myImage, fullImageUrl);

          LocalStorage.myName = response.data!.name;
          LocalStorage.myImage = fullImageUrl;
        }

        // --- THE FIX IS HERE ---
        // 1. Find the controller of the previous screen and tell it to refresh.
        if (Get.isRegistered<ProfileController>()) {
          final ProfileController profileController =
              Get.find<ProfileController>();
          profileController.loadUserData();
        }

        // 2. Now, go back. The previous screen will already have the new data.
        Get.back();
        AppSnackBar.success(
          response.message,
        ); // Show snackbar on the previous screen
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
