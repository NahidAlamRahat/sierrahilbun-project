import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/reset_password_onTap_button_controller.dart';

class ResetPasswordScreen extends StatelessWidget {

  ResetPasswordController controller = Get.put(ResetPasswordController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppImagePath.resetPasswordImage),
        
            SizedBox(height: 20,),
        
        
            TextWidget(text: 'Set Your New Password',
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
        
            SizedBox(height: 8,),
        
            TextWidget(text: 'Choose a strong, unique password to secure your account.',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
        
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  buildForm(),
        
                  SizedBox(height: AppSize.height(value: 40)),
        
             /*     CommonElevatedButton(
                    text: 'Reset Password',
                    width: double.infinity,
                    onPressed: () {Get.offAllNamed(AppRoutes.signInScreen);},
                    backgroundColor: AppColor.backgroundColor,
                    borderRadius: 100,
                  ),*/
        
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }

  /// Text Field
  Widget buildForm() {
    return Form(
      child: Column(
        children: [
          TextFieldWidget(
            controller: controller.newPasswordController,
            hintText: 'Password',
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            suffixIcon: true,
          ),

          SizedBox(height: AppSize.height(value: 20)),

          TextFieldWidget(
            keyboardType: TextInputType.visiblePassword,
            controller: controller.confirmPasswordController,
            hintText: 'Confirm Password',
            maxLines: 1,
            suffixIcon: true,
          ),
        ],
      ),
    );
  }
}
