import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/widgets/button_widget/button_widget.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  // Use Get.put() to initialize the controller safely
  final ForgotPasswordController controller =
      Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: controller.formKey, // Associate the form key
          child: Column(
            children: [
              Image.asset(AppImagePath.forgotPassImage),
              const TextWidget(
                text: "Forgot Your Password?",
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              const TextWidget(
                text:
                    "No worries! Enter your email address below and we'll send you a link to reset your password.",
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: AppSize.height(value: 20)),
              TextFieldWidget(
                validator: controller.validateEmail,
                borderRadius: 12,
                controller: controller.emailController,
                hintText: 'Enter Your Email',
              ),
              SizedBox(height: AppSize.height(value: 30)),

              // --- UPDATED BUTTON ---
              Obx(() {
                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.commonButtonColor,
                        ),
                      )
                    : ButtonWidget(
                        backgroundColor: AppColors.commonButtonColor,
                        onPressed: controller
                            .sendVerificationCode, // Connect to controller method
                        label: 'Get Verification Code',
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
