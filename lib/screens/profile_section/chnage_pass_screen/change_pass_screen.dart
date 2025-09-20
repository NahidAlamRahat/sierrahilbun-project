import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/screens/profile_section/chnage_pass_screen/controller/change_password_controller.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_button/app_button.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class ChangePassScreen extends StatelessWidget {
  ChangePassScreen({super.key});

  // Initialize the controller using Get.put()
  final ChangePasswordController controller = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.width(value: 16),
            vertical: AppSize.width(value: 20),
          ),
          // --- UPDATED BUTTON WITH LOADING STATE ---
          child: Obx(() {
            return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator(color: AppColors.commonButtonColor))
              : AppButton(
                  onTap: controller.changePassword, // Connect to controller method
                  filColor: AppColors.commonButtonColor,
                  title: "Save",
                  titleSize: AppSize.width(value: 18),
                  borderRadius: BorderRadius.circular(AppSize.width(value: 24)),
                );
          }),
        ),
      ),
      appBar: AppbarWidget(
        backgroundColor: AppColors.appBackgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        text: "Change Password",
        textWidget: const TextWidget(
          text: "Change Password",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          textAlignment: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey, // Connect form key
          child: Column(
            children: [
              AppImage(
                width: AppSize.size.width * 0.6,
                path: AppImagePath.changePassImg,
              ),
              Padding(
                padding: EdgeInsets.all(AppSize.width(value: 16)),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 4), blurRadius: 10),
                    ],
                    borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(AppSize.width(value: 20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(text: 'Old Password', fontFamily: 'Outfit', fontWeight: FontWeight.w500),
                      SizedBox(height: AppSize.height(value: 8)),
                      TextFieldWidget(
                        borderRadius: 12,
                        controller: controller.oldPasswordController, // Use correct controller
                        hintText: "Old Password",
                        validator: controller.validateOldPassword, // Add validator
                        suffixIcon: true,
                      ),
                      SizedBox(height: AppSize.height(value: 16)),
                      const TextWidget(text: 'New Password', fontFamily: 'Outfit', fontWeight: FontWeight.w500),
                      SizedBox(height: AppSize.height(value: 8)),
                      TextFieldWidget(
                        borderRadius: 12,
                        controller: controller.newPasswordController, // Use correct controller
                        hintText: "New Password",
                        validator: controller.validateNewPassword, // Add validator
                         suffixIcon: true,
                      ),
                      SizedBox(height: AppSize.height(value: 16)),
                      const TextWidget(text: 'Confirm Password', fontFamily: 'Outfit', fontWeight: FontWeight.w500),
                      SizedBox(height: AppSize.height(value: 8)),
                      TextFieldWidget(
                        borderRadius: 12,
                        controller: controller.confirmPasswordController, // Use correct controller
                        hintText: "Enter Confirm Password",
                        validator: controller.validateConfirmPassword, // Add validator
                         suffixIcon: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
