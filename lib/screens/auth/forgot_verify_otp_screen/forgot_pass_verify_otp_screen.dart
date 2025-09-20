import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/widgets/appbar_widget/appbar_widget.dart';
import 'package:sierrahilbun/widgets/button_widget/button_widget.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/forgot_pass_verify_otp_screen_controller.dart';

class ForgotPassVerifyOtpScreen extends StatelessWidget {
  ForgotPassVerifyOtpScreen({super.key});

  final ForgotPassVerifyOtpScreenController controller =
      Get.find<ForgotPassVerifyOtpScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Image.asset(AppImagePath.otpImage),
            const TextWidget(
              text: "Verification Code",
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
            const TextWidget(
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

            
            Obx(() {
              return controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.commonButtonColor,
                      ),
                    )
                  : ButtonWidget(
                      onPressed:
                          controller.onTapVerifyButton, 
                      label: "Verify and Continue",
                      backgroundColor: AppColors.commonButtonColor,
                    );
            }),
            SizedBox(height: AppSize.height(value: 20)),

            
            Obx(() {
              return controller.canResend.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextWidget(
                          text: "Didn't receive code?",
                          fontColor: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        const SpaceWidget(spaceWidth: 6),
                        TextButtonWidget(
                          onPressed:
                              controller.resendCode, 
                          text: 'Resend',
                          textColor: AppColors.commonButtonColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    )
                  : TextWidget(
                      text: "Send code again in ${controller.formatTime()}",
                      fontColor: Colors.grey.shade500,
                    );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: PinCodeTextField(
        validator: (value) {
          if (value == null || value.length != 6) {
            return 'Enter the 6-digit code';
          }
          return null;
        },
        length: 6,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 50,
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedFillColor: Colors.white,
          activeColor: AppColors.commonButtonColor,
          inactiveColor: Colors.grey.shade300,
          selectedColor: AppColors.commonButtonColor,
        ),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        controller: controller.otpTextEditingController,
        appContext: context,
      ),
    );
  }
}
