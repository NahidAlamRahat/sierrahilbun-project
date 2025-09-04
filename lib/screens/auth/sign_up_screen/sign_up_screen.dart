import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/screens/auth/sign_in_screen/widgets/social_login_widget.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/image_widget/image_widget.dart';
import '../../terms_condition_screen/terms_condition_screen.dart';
import 'controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController _signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrivacyPolicyWidget(),
            buildSignUpPromptSection(context),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _signUpController.formKey,  // ✅ only one Form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SpaceWidget(spaceHeight: 24),
                Center(
                  child: ImageWidget(
                    width: 127,
                    height: 130,
                    imagePath: AppImagePath.appLogo,
                    fit: BoxFit.contain,
                  ),
                ),

                Center(
                  child: Text(
                    "Create Your Account",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    "Let's dive in into your account",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SpaceWidget(spaceHeight: 20),

                // ✅ FormField
                buildFormFieldColumn(),

                const SpaceWidget(spaceHeight: 20),

                // ✅ Submit Button
                ButtonWidget(
                  backgroundColor: AppColors.commonButtonColor,
                  onPressed: () => _signUpController.onTapSignUpButton(),
                  label: "Sign Up ➔",
                  buttonWidth: double.infinity,
                ),

                const SpaceWidget(spaceHeight: 20),
                buildTermsCheckbox(),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget buildFormFieldColumn() {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  TextWidget(
                    text: 'Full Name',
                    fontColor: AppColors.green500,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  TextFieldWidget(
                    controller: _signUpController.nameController,
                    hintText: 'Enter Your Full Name',
                    borderRadius: 12,
                    validator: _signUpController.validateName,
                  ),

                  const SpaceWidget(spaceHeight: 12),

                  // ✅ Email
                  TextWidget(
                    text: 'Email',
                    fontColor: AppColors.green500,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  TextFieldWidget(
                    controller: _signUpController.emailController,
                    hintText: 'Enter Your E-Mail',
                    borderRadius: 12,
                    validator: _signUpController.validateEmail,
                  ),

                  const SpaceWidget(spaceHeight: 12),

                  // ✅ Phone
                  TextWidget(
                    text: 'Phone Number',
                    fontColor: AppColors.green500,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  TextFieldWidget(
                    controller: _signUpController.phoneController,
                    hintText: 'Enter Your Phone Number',
                    borderRadius: 12,
                    validator: _signUpController.validatePhone,
                  ),

                  const SpaceWidget(spaceHeight: 12),

                  // ✅ Password
                  TextWidget(
                    text: AppStrings.password,
                    fontColor: AppColors.green500,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  TextFieldWidget(
                    controller: _signUpController.passwordController,
                    hintText: 'Enter Password',
                    borderRadius: 12,
                    suffixIcon: true,
                    validator: _signUpController.validatePassword,
                  ),

                  const SpaceWidget(spaceHeight: 12),

                  // ✅ Confirm Password
                  TextWidget(
                    text: AppStrings.confirmPassword,
                    fontColor: AppColors.green500,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  TextFieldWidget(
                    controller: _signUpController.confirmPasswordController,
                    hintText: 'Confirm Password',
                    borderRadius: 12,
                    suffixIcon: true,
                    validator: _signUpController.validateConfirmPassword,
                  ),
                ],
              );
  }

  /// SignUp Prompt Section
  Widget buildSignUpPromptSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isMobile = screenWidth < 400;

    return Column(
      mainAxisSize: MainAxisSize.min, // ⬅️ Column টা shrink হবে
      crossAxisAlignment: CrossAxisAlignment.end, // ডান দিকে align হবে
      children: [
        TextWidget(
          text: "Already have an account?",
          fontWeight: FontWeight.w500,
          fontSize: isTablet ? 14 : (isMobile ? 11 : 12),
        ),
        TextButtonWidget(
          onPressed: () {
            Get.toNamed(AppRoutes.signInScreen);
          },
          text: 'Sign In',
          textColor: Color.fromRGBO(72, 177, 76, 1),
          fontSize: isTablet ? 20 : (isMobile ? 16 : 18),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }

  Row buildTermsCheckbox() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<SignUpController>(
          builder: (signUpController) {
            return GestureDetector(
              onTap: () {
                signUpController.toggleCheckbox(); // Update checkbox state in controller
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: signUpController.isChecked ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: signUpController.isChecked
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
            );
          },
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text('I agree to the Terms & Conditions and Privacy Policy'),
        ),
      ],
    );
  }



}
