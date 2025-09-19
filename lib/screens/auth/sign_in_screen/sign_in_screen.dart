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
// Note: Assuming PrivacyPolicyWidget is in this location
import 'controller/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController _userSignInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Assuming this is a valid widget in your project
            // PrivacyPolicyWidget(),
            const Text("Privacy Policy"), // Placeholder
            buildSignUpPromptSection(context),
          ],
        ),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _userSignInController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SpaceWidget(spaceHeight: 24),
                const Center(
                  child: ImageWidget(
                    width: 127,
                    height: 130,
                    imagePath: AppImagePath.appLogo,
                    fit: BoxFit.contain,
                  ),
                ),
                const SpaceWidget(spaceHeight: 8),
                const Center(
                  child: SizedBox(
                    width: 233,
                    child: Text(
                      "Let's Get Started!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF100F0E) /* Black */,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                      ),
                    ),
                  ),
                ),
                const SpaceWidget(spaceHeight: 4),
                const Center(
                  child: SizedBox(
                    width: 233,
                    child: Text(
                      "Let's dive in into your account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF100F0E) /* Black */,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ),
                ),
                const SpaceWidget(spaceHeight: 12),
                const TextWidget(
                  text: AppStrings.email,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextFieldWidget(
                  borderRadius: 12,
                  controller: _userSignInController.emailController,
                  hintText: 'Enter Your E-Mail',
                  maxLines: 1,
                  validator: _userSignInController.validateEmail,
                ),
                const SpaceWidget(spaceHeight: 12),
                const TextWidget(
                  text: AppStrings.password,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextFieldWidget(
                  controller: _userSignInController.passwordController,
                  hintText: 'Enter Your Password',
                  maxLines: 1,
                  validator: _userSignInController.validatePassword,
                  suffixIcon: true,
                  borderRadius: 12,
                  onFieldSubmitted: (submit) =>
                      _userSignInController.onTapSignInButton(),
                ),
                const SpaceWidget(spaceHeight: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButtonWidget(
                    onPressed: () {
                      Get.toNamed(AppRoutes.forgotPasswordScreen);
                    },
                    text: AppStrings.forgetPassword,
                    textColor: AppColors.grey700,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SpaceWidget(spaceHeight: 12),

                /// --- ERROR HANDLING WITH GETX SNACKBAR --- ///
                Obx(() {
                  // Show a loading indicator OR the login button
                  return _userSignInController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.green500,
                          ),
                        )
                      : ButtonWidget(
                          backgroundColor: const Color.fromRGBO(72, 177, 76, 1),
                          // Connect the button to the controller's function
                          onPressed: _userSignInController.onTapSignInButton,
                          label: "Sign In ➔",
                          buttonWidth: double.infinity,
                          buttonRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        );
                }),
                const SpaceWidget(spaceHeight: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: AppSize.height(value: 1),
                      width: AppSize.width(value: 125),
                      color: AppColors.grey300,
                    ),
                    const SpaceWidget(spaceWidth: 8),
                    const TextWidget(
                      text: AppStrings.orLogInWith,
                      fontColor: AppColors.grey700,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    const SpaceWidget(spaceWidth: 8),
                    Container(
                      height: AppSize.height(value: 1),
                      width: AppSize.width(value: 125),
                      color: AppColors.grey300,
                    ),
                  ],
                ),
                const SpaceWidget(spaceHeight: 16),
                SocialLoginWidget(
                  imagePath: AppImagePath.googleIcon,
                  text: "Continue with Google",
                  onTap: () {
                    // TODO: Implement Google Sign In
                  },
                ),
              ],
            ),
          ),
        ),
      ),
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
          text: "Don't Have an Account?",
          fontWeight: FontWeight.w500,
          fontSize: isTablet ? 14 : (isMobile ? 11 : 12),
        ),
        TextButtonWidget(
          onPressed: () {
            Get.toNamed(AppRoutes.signUpScreen);
          },
          text: 'Sign Up',
          textColor: const Color.fromRGBO(72, 177, 76, 1),
          fontSize: isTablet ? 20 : (isMobile ? 16 : 18),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
