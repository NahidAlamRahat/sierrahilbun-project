import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sierrahilbun/constants/api_urls.dart';
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
  var selectedImagePath = ''.obs; // Holds the path of the newly picked image

  @override
  void onInit() {
    super.onInit();
    // Initialize controllers with data saved in LocalStorage
    nameController = TextEditingController(text: LocalStorage.myName);
    phoneController = TextEditingController(text: "01786543210"); // Placeholder
    emailController = TextEditingController(text: LocalStorage.myEmail);
    addressController = TextEditingController(text: "Dhaka"); // Placeholder
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.onClose();
  }

  /// Picks an image from the device gallery after checking permissions.
  Future<void> pickImageFromGallery() async {
    // 1. Request permission to access the photo gallery.
    final status = await Permission.photos.request();

    if (status.isGranted) {
      // 2. If permission is granted, use image_picker to open the gallery.
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // 3. If an image is successfully picked, update the state.
        selectedImagePath.value = image.path;
      }
    } else if (status.isPermanentlyDenied) {
      // 4. If permission is permanently denied, guide the user to settings.
      AppSnackBar.message("Permission denied. Please enable photos access in your device settings.");
      await openAppSettings();
    } else {
      AppSnackBar.message("Photo access is required to select a profile picture.");
    }
  }

  /// Calls the repository to update the user's profile.
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

        // --- THE FIX IS HERE ---
        if (response.success && response.data != null) {
          final String relativePath = response.data!.profileImage ?? '';
          
          // 1. Construct the full, absolute URL for the image.
          final String fullImageUrl = relativePath.isNotEmpty
              ? '${ApiUrls.baseImageUrl}$relativePath'
              : '';

          // 2. Save the FULL URL to SharedPreferences.
          await LocalStorage.setString(LocalStorageKeys.myName, response.data!.name);
          await LocalStorage.setString(LocalStorageKeys.myImage, fullImageUrl);

          // 3. ALSO, update the static variable in memory so the UI can react instantly.
          LocalStorage.myName = response.data!.name;
          LocalStorage.myImage = fullImageUrl;
        }

        AppSnackBar.success(response.message);
        Get.back(); // Go back to the profile screen

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
