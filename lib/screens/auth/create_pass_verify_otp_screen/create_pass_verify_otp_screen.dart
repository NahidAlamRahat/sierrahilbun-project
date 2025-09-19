import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/widgets/appbar_widget/appbar_widget.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_log/app_log.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../../terms_condition_screen/terms_condition_screen.dart';
import 'controller/create_pass_verify_otp_screen_controller.dart';

class CreatePassVerifyOtpScreen extends StatelessWidget {
  CreatePassVerifyOtpScreen({super.key});

  final CreatePassVerifyOtpScreenController controller = Get.find<CreatePassVerifyOtpScreenController>();

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
              text: "Verify Your Account",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            const TextWidget(
              text:
                  "We’ve sent a verification code to your email. Enter the code below to continue and secure your account.",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: AppSize.height(value: 30)),
            TextWidget(
              text: "We've Sent a Code to ${controller.email}",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: AppSize.height(value: 20)),
            _buildPinCodeTextField(context),
            SizedBox(height: AppSize.height(value: 20)),

            // --- UPDATED BUTTON & LOADING INDICATOR ---
            Obx(() {
              return controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.commonButtonColor,
                      ),
                    )
                  : ButtonWidget(
                      backgroundColor: const Color.fromRGBO(72, 177, 76, 1),
                      onPressed: controller
                          .onTapVerifyButton, // <-- Connect to controller method
                      label: "Verify and Continue",
                      buttonWidth: double.infinity,
                      buttonRadius: const BorderRadius.all(Radius.circular(8)),
                    );
            }),

            SizedBox(height: AppSize.height(value: 20)),

            // --- RESEND CODE LOGIC ---
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
                          onPressed: controller
                              .resendCode, // <-- Connect to controller method
                          text: 'Resend',
                          textColor: AppColors.commonButtonColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    )
                  : TextWidget(
                      text: "Send code again in ${controller.formatTime()}",
                      fontColor: Colors.grey.shade500,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
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
          selectedFillColor: Colors.white,
          activeColor: AppColors.commonButtonColor,
          inactiveColor: Colors.grey.shade300,
          selectedColor: AppColors.commonButtonColor,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        controller: controller.otpTextEditingController,
        appContext: context,
      ),
    );
  }
}
