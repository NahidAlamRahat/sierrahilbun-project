
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sierrahilbun/screens/auth/sign_in_screen/sign_in_screen.dart';
import 'package:sierrahilbun/screens/terms_condition_screen/terms_condition_screen.dart';
import '../screens/auth/create_pass_verify_otp_screen/create_pass_verify_otp_screen.dart';
import '../screens/auth/create_password_screen/create_password_screen.dart';
import '../screens/auth/forgot_password/forgot_password_screen.dart';
import '../screens/auth/forgot_verify_otp_screen/controller/forgot_pass_verify_otp_screen_controller.dart';
import '../screens/auth/forgot_verify_otp_screen/forgot_pass_verify_otp_screen.dart';
import '../screens/auth/location_screen/location_screen.dart';
import '../screens/auth/sign_up_screen/sign_up_screen.dart';
import '../screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/profile_section/chnage_pass_screen/change_pass_screen.dart';
import '../screens/profile_section/chnage_profile_info/chnage_profile_screen.dart';
import '../screens/profile_section/profile_screen/profile_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../screens/upload_document/upload_document_screen.dart';
import 'app_routes.dart';

class RouteManager {
  RouteManager._();

  static const initial = AppRoutes.splashScreen;

  static List<GetPage> getPages() {
    return [
     // General Screens
      GetPage(
        name: AppRoutes.splashScreen,
        page: () =>  SplashScreen(),
        // binding: GeneralBindings(),
      ),


      GetPage(
        name: AppRoutes.signInScreen,
        page: () =>  SignInScreen(),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.termsAndConditionScreen,
        page: () => TermsAndConditionsScreen (),
        // binding: GeneralBindings(),
      ),


      GetPage(
        name: AppRoutes.forgotPasswordScreen,
        page: () => ForgotPasswordScreen (),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.forgotPassVerifyOtpScreen,
        page: () => ForgotPassVerifyOtpScreen (),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.createNewPasswordScreen,
        page: () => CreateNewPasswordScreen (),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.signUpScreen,
        page: () => SignUpScreen (),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.createPassVerifyOtpScreen,
        page: () => CreatePassVerifyOtpScreen (),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.locationScreen,
        page: () => LocationScreen (),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.homeScreen,
        page: () => HomeScreen(),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.profileScreen,
        page: () => ProfileScreen(),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.changeProfileScreen,
        page: () => ChangeProfileScreen(),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.changePassScreen,
        page: () => ChangePassScreen(),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.uploadDocumentScreen,
        page: () => UploadDocumentScreen(),
        // binding: GeneralBindings(),
      ),

      GetPage(
        name: AppRoutes.swipeableBottomNavigation,
        page: () => SwipeableBottomNavigation(),
        // binding: GeneralBindings(),
      ),
    ];
  }
}
