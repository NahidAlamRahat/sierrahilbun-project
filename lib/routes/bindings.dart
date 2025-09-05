// app_bindings.dart
import 'package:get/get.dart';

import '../screens/home_screen/controller/home_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => ApplicationDetailsController());

  }
}
