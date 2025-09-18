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
import 'controller/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController _userSignInController =
      Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrivacyPolicyWidget(),
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
                Center(
                  child: const ImageWidget(
                    width: 127,
                    height: 130,
                    imagePath: AppImagePath.appLogo,
                    fit: BoxFit.contain,
                  ),
                ),
                /*const SpaceWidget(spaceHeight: 30),
                const TextWidget(
                  text: AppStrings.signInTitle,
                  fontColor: AppColors.green500,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),*/

                const SpaceWidget(spaceHeight: 8),

                Center(
                  child: SizedBox(
                    width: 233,
                    child: Text(
                      "Let's Get Started!",
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF100F0E) /* Black */,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                      ),
                    ),
                  ),
                ),

                const SpaceWidget(spaceHeight: 4),

                Center(
                  child: SizedBox(
                    width: 233,
                    child: Text(
                      "Let's dive in into your occount",
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF100F0E) /* Black */,
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
                  onFieldSubmitted: (submit) =>  _userSignInController.onTapSignInButton() ,
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
                // GetBuilder<SignInApiController>(builder: (controllers) {
                //   return Visibility(
                //     visible: controllers.inProgress == false,
                //     replacement:
                //         const Center(child: CircularProgressIndicator()),
                //     child:
                    ButtonWidget(
                      backgroundColor: Color.fromRGBO(72, 177, 76, 1),
                      //after api integration
                      // onPressed: _userSignInController.onTapSignInButton,

                      onPressed: (){
                        Get.offAllNamed(AppRoutes.swipeableBottomNavigation);

                      },

                      label: "Sign In ➔",
                      buttonWidth: double.infinity,
                      buttonRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                //   );
                // }),
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

                 /// Google and Apple login
                const SpaceWidget(spaceHeight: 16),
                // SocialLoginWidget(
                //   imagePath: AppImagePath.appleIcon,
                //   text: AppStrings.signInWithApple,
                //   onTap: () {
                //     Get.offAllNamed(AppRoutes.userBottomNav);
                //   },
                // ),
                // const SpaceWidget(spaceHeight: 12),
                SocialLoginWidget(
                  imagePath: AppImagePath.googleIcon,
                  text: "Continue with Google",
                  onTap: () {
                    Get.offAllNamed(AppRoutes.swipeableBottomNavigation);
                  },
                ),

                // buildSignUpPromptSection(context),

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
      mainAxisSize: MainAxisSize.min, // ⬅️ Column টা shrink হবে
      crossAxisAlignment: CrossAxisAlignment.end, // ডান দিকে align হবে
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
          textColor: Color.fromRGBO(72, 177, 76, 1),
          fontSize: isTablet ? 20 : (isMobile ? 16 : 18),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }



}
