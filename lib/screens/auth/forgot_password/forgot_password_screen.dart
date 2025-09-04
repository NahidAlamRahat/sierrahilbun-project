import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/widgets/button_widget/button_widget.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../../terms_condition_screen/terms_condition_screen.dart';
import 'controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {

  ForgotPasswordOnTapButtonController controller = Get.put(
      ForgotPasswordOnTapButtonController());

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppImagePath.forgotPassImage),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
        
                  TextWidget(text: "Forgot Your Password?",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
        
                  TextWidget(
                    text: "No worries! Enter your email address below and we'll send you a link to reset your password.",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
        
                  SizedBox(height: AppSize.height(value: 20)),

                 TextFieldWidget(
                   validator: controller.validateEmail,
                     borderRadius: 12,
                     controller: controller.emailController, hintText: 'Enter Your Email'),
        
                  SizedBox(height: AppSize.height(value: 30)),

                  ButtonWidget(
                    backgroundColor: AppColors.commonButtonColor,
                    onPressed: () {
                      Get.toNamed(AppRoutes.forgotPassVerifyOtpScreen,
                          arguments: {'email': controller.emailController.text
                              .trim()});
                    },
                    label: 'Get Verification Code',
                  )
        
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }

  /// Text Field
  Widget buildForm({controller}) {
    return Form(
      child: Column(
        children: [
          TextFieldWidget(
            controller: controller.emailController,
            hintText: 'Enter Your Email Address',
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            validator: controller.validateEmail,
          ),

        ],
      ),
    );
  }
}
