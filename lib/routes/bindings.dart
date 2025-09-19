// app_bindings.dart
import 'package:get/get.dart';
import 'package:sierrahilbun/screens/auth/create_pass_verify_otp_screen/controller/create_pass_verify_otp_screen_controller.dart';

import '../screens/home_screen/controller/home_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => ApplicationDetailsController());
    //otp
    Get.lazyPut(() => CreatePassVerifyOtpScreenController());
  }
}
