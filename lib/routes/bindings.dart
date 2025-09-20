// app_bindings.dart
import 'package:get/get.dart';
import 'package:sierrahilbun/screens/auth/create_pass_verify_otp_screen/controller/create_pass_verify_otp_screen_controller.dart';
import 'package:sierrahilbun/screens/auth/create_password_screen/controller/create_password_onTap_button_controller.dart';
import 'package:sierrahilbun/screens/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:sierrahilbun/screens/auth/forgot_verify_otp_screen/controller/forgot_pass_verify_otp_screen_controller.dart';
import 'package:sierrahilbun/screens/auth/sign_in_screen/controller/sign_in_controller.dart';
import 'package:sierrahilbun/screens/auth/sign_up_screen/controller/sign_up_controller.dart';
import 'package:sierrahilbun/screens/profile_section/chnage_pass_screen/controller/change_password_controller.dart';
import 'package:sierrahilbun/screens/profile_section/chnage_profile_info/controller/change_profile_screen_controller.dart';
import 'package:sierrahilbun/screens/profile_section/profile_screen/controller/profile_controller.dart';

import '../screens/home_screen/controller/home_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => ApplicationDetailsController());
    //otp
    Get.lazyPut(() => CreatePassVerifyOtpScreenController());
    //signin
    Get.lazyPut(() => SignInController());
    //signup
    Get.lazyPut(() => SignUpController());
    //forgot password
    Get.lazyPut(() => ForgotPasswordController());
    //forgot verify otp
    Get.lazyPut(() => ForgotPassVerifyOtpScreenController());
    //create new password
    Get.lazyPut(() => CreateNewPasswordController());
    //change password
    Get.lazyPut(() => ChangePasswordController());
    //profile
    Get.lazyPut(() => ProfileController());
    //change profile info
    Get.lazyPut(() => ChangeProfileController());
  }
}
