import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/screens/profile_section/chnage_profile_info/controller/change_profile_screen_controller.dart';
import 'package:sierrahilbun/services/storage/storage_service.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_button/app_button.dart';
import '../../../widgets/app_image/app_image_circular.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class ChangeProfileScreen extends StatelessWidget {
  ChangeProfileScreen({super.key});

  final ChangeProfileController controller =
      Get.find<ChangeProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      resizeToAvoidBottomInset: true, // Allow resizing
      appBar: AppbarWidget(
        backgroundColor: AppColors.appBackgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        textWidget: const TextWidget(
          text: "Change Profile Information",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          textAlignment: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 16)),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              SizedBox(height: AppSize.height(value: 20)),
              GestureDetector(
                onTap: controller.pickImageFromGallery, // Make avatar tappable
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // Obx makes the avatar reactive to image selection
                    Obx(() {
                      return AppImageCircular(
                        fit: BoxFit.cover,
                        // If a new image is selected, show it from the file path.
                        // Otherwise, show the existing image from the network URL.
                        filePath: controller.selectedImagePath.value.isNotEmpty
                            ? controller.selectedImagePath.value
                            : null,
                        url: controller.selectedImagePath.value.isEmpty
                            ? LocalStorage.myImage
                            : null,
                        width: AppSize.width(value: 148),
                        height: AppSize.width(value: 148),
                      );
                    }),
                    // Edit Icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.commonButtonColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.height(value: 20)),
              Card(
                elevation: 3,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        text: 'Full Name',
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: AppSize.height(value: 8)),
                      TextFieldWidget(
                        borderRadius: 12,
                        controller: controller.nameController,
                        hintText: "Enter Name",
                      ),
                      SizedBox(height: AppSize.height(value: 16)),
                      const TextWidget(
                        text: 'Phone Number',
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: AppSize.height(value: 8)),
                      TextFieldWidget(
                        borderRadius: 12,
                        controller: controller.phoneController,
                        hintText: "Enter Number",
                      ),
                      SizedBox(height: AppSize.height(value: 16)),
                      const TextWidget(
                        text: 'Email',
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: AppSize.height(value: 8)),
                      TextFieldWidget(
                        borderRadius: 12,
                        controller: controller.emailController,
                        hintText: "Enter Email",
                        readOnly: true,
                      ), // Email is not editable
                      SizedBox(height: AppSize.height(value: 16)),
                      const TextWidget(
                        text: 'Address',
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: AppSize.height(value: 8)),
                      TextFieldWidget(
                        borderRadius: 12,
                        controller: controller.addressController,
                        hintText: "Enter Address",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSize.width(value: 16)),
          child: Obx(() {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.commonButtonColor,
                    ),
                  )
                : AppButton(
                    onTap: controller.updateProfile,
                    filColor: AppColors.commonButtonColor,
                    title: "Save",
                    titleSize: AppSize.width(value: 18),
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 24),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
