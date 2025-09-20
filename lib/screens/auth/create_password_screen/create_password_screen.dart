import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/screens/auth/create_password_screen/controller/create_password_onTap_button_controller.dart';
import 'package:sierrahilbun/widgets/button_widget/button_widget.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({super.key});

  final CreateNewPasswordController controller = Get.find<CreateNewPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              SizedBox(
                height: AppSize.height(value: 60),
              ), // Add padding from top
              Image.asset(AppImagePath.resetPasswordImage),
              SizedBox(height: 20),
              const TextWidget(
                text: 'Create Your Password',
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8),
              const TextWidget(
                text:
                    'Choose a strong, unique password to secure your account.',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: AppSize.height(value: 30)),
              buildForm(),
              SizedBox(height: AppSize.height(value: 40)),

              // --- UPDATED BUTTON WITH LOADING STATE ---
              Obx(() {
                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.commonButtonColor,
                        ),
                      )
                    : ButtonWidget(
                        label: "Save New Password",
                        backgroundColor: AppColors.commonButtonColor,
                        onPressed: controller.saveNewPassword,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// Text Field
  Widget buildForm() {
    return Column(
      children: [
        TextFieldWidget(
          borderRadius: 12,
          controller: controller.newPasswordController,
          hintText: 'New Password',
          keyboardType: TextInputType.visiblePassword,
          maxLines: 1,
          suffixIcon: true,
          validator: controller.validatePassword, // Added validator
        ),
        SizedBox(height: AppSize.height(value: 20)),
        TextFieldWidget(
          borderRadius: 12,
          keyboardType: TextInputType.visiblePassword,
          controller: controller.confirmPasswordController,
          hintText: 'Confirm Password',
          maxLines: 1,
          suffixIcon: true,
          validator: controller.validateConfirmPassword, // Added validator
        ),
      ],
    );
  }
}
