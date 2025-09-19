// app_bindings.dart
import 'package:get/get.dart';
import 'package:sierrahilbun/screens/auth/create_pass_verify_otp_screen/controller/create_pass_verify_otp_screen_controller.dart';
import 'package:sierrahilbun/screens/auth/sign_in_screen/controller/sign_in_controller.dart';
import 'package:sierrahilbun/screens/auth/sign_up_screen/controller/sign_up_controller.dart';

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
  }
}
