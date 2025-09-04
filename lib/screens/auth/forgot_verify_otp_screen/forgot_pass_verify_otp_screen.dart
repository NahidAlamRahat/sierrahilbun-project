import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/widgets/appbar_widget/appbar_widget.dart';
import 'package:sierrahilbun/widgets/button_widget/button_widget.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_log/app_log.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../../terms_condition_screen/terms_condition_screen.dart';
import 'controller/forgot_pass_verify_otp_screen_controller.dart';

class ForgotPassVerifyOtpScreen extends StatelessWidget {

  ForgotPassVerifyOtpScreenController controller = Get.put(ForgotPassVerifyOtpScreenController());




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppbarWidget(),
      backgroundColor: Colors.white,
      bottomNavigationBar: PrivacyPolicyWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppImagePath.otpImage),
        
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
        
                  TextWidget(text: "Verification Code",
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
        
                  TextWidget(
                    text: "Please enter the code sent to your email to continue.",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: AppSize.height(value: 30)),
        
        
                  TextWidget(
                    text: "We've Sent a Code to ${controller.email}",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
        
                  SizedBox(height: AppSize.height(value: 20)),
        
                  _buildPinCodeTextField(context),
        
                  SizedBox(height: AppSize.height(value: 30)),


                  ButtonWidget(
                    onPressed: (){Get.toNamed(AppRoutes.createNewPasswordScreen);},
                    label: "Verify and Continue",
                    backgroundColor: AppColors.commonButtonColor,
                  ),
        
                  SizedBox(height: AppSize.height(value: 20)),
        
                  Obx(() {
                    return TextWidget(
                      text: controller.canResend.value
                          ? 'Remaining Time 00.00'
                          : "Send code again in ${controller.formatTime()}",
                      fontColor: controller.canResend.value
                          ? Colors.grey
                          : Colors.grey.shade500,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    );
                  }),
        
                  const SpaceWidget(spaceHeight: 12),
                  Obx(() {
                    // Debugging check
                    if (controller.canResend.value) {
                      appLog("Resend Code Button is now visible!");
                    }
                    return controller.canResend.value
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            text: "Didn't receive code?'",
                            fontColor: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            maxLines: 1,
                          ),
                          const SpaceWidget(spaceWidth: 6),
                          TextButtonWidget(
                            onPressed: () {
                              controller.resendCode();
                            },
                            text: 'Resend',
                            textColor: AppColors.commonButtonColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    )
                        : const SizedBox.shrink();
                  }),
        
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }
  Widget _buildPinCodeTextField(BuildContext context) {
    return Form(
       key: controller.formKey,
      child: PinCodeTextField(
        ///validator
        validator: (value) {
          if(value?.trim().isEmpty == true){
            return 'Enter Correct Otp';
          }
          return null;
        } ,

        length: 6,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        obscureText: false,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
         controller: controller.otpTextEditingController,
        appContext: context,
      ),
    );
  }

}



/*
class RichText extends StatelessWidget {

  final VoidCallback? voidCallback;
  final String text1;
  final String text2;


  RichText({
    super.key,

     this.voidCallback,
    required this.text1,
    required this.text2

  });



  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1 ,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: text2',
            style: TextStyle(
              color: Colors.themeColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                voidCallback();
              },
          ),
        ],
      ),
    );
  }
}
*/
