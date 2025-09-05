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
          children: [PrivacyPolicyWidget(), buildSignUpPromptSection(context)],
        ),
      ),
      body: Form(
        key: _signUpController.formKey,
        child: CustomScrollView(
          slivers: [
            // App Bar with animated logo and titles
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              expandedHeight: 225.0,
              automaticallyImplyLeading: false,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Calculate the collapse ratio (0.0 = fully expanded, 1.0 = fully collapsed)
                  final double appBarHeight = constraints.maxHeight;
                  final double statusBarHeight = MediaQuery.of(context).padding.top;
                  final double minHeight = kToolbarHeight + statusBarHeight;
                  final double maxHeight = 225.0 + statusBarHeight;

                  final double collapseRatio = ((maxHeight - appBarHeight) / (maxHeight - minHeight)).clamp(0.0, 1.0);

                  // Calculate logo size based on collapse ratio
                  final double logoSize = (127 * (1 - collapseRatio * 0.8)).clamp(25.0, 127.0);
                  final double logoHeight = (130 * (1 - collapseRatio * 0.8)).clamp(25.0, 130.0);

                  // Calculate opacity for logo
                  final double logoOpacity = (1 - collapseRatio * 1.5).clamp(0.0, 1.0);

                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Create Your Account",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Let's dive in into your account",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    titlePadding: EdgeInsets.only(bottom: 16),
                    background: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            opacity: logoOpacity,
                            duration: Duration.zero, // Instant animation for smooth scroll
                            child: AnimatedContainer(
                              duration: Duration.zero,
                              width: logoSize,
                              height: logoHeight,
                              child: ImageWidget(
                                width: logoSize,
                                height: logoHeight,
                                imagePath: AppImagePath.appLogo,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 23),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Main content
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SpaceWidget(spaceHeight: 20),

                  // Form Fields
                  buildFormFieldColumn(),

                  const SpaceWidget(spaceHeight: 20),

                  // Submit Button
                  ButtonWidget(
                    backgroundColor: AppColors.commonButtonColor,
                    onPressed: () => _signUpController.onTapSignUpButton(),
                    label: "Sign Up ➔",
                    buttonWidth: double.infinity,
                  ),

                  // Google and Apple login
                  const SpaceWidget(spaceHeight: 16),
                  SocialLoginWidget(
                    imagePath: AppImagePath.googleIcon,
                    text: "Continue with Google",
                    onTap: () {
                      Get.offAllNamed(AppRoutes.swipeableBottomNavigation);
                    },
                  ),

                  const SpaceWidget(spaceHeight: 20),
                  buildTermsCheckbox(),

                  const SpaceWidget(spaceHeight: 40), // Bottom padding
                ]),
              ),
            ),
          ],
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

        // Email
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

        // Phone
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

        // Password
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

        // Confirm Password
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
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
                signUpController.toggleCheckbox();
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: signUpController.isChecked
                      ? Colors.green
                      : Colors.transparent,
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