import 'package:sierrahilbun/constants/api_urls.dart';
import 'package:sierrahilbun/model/api_response_model.dart';
import 'package:sierrahilbun/model/otp_response_model.dart';
import 'package:sierrahilbun/model/user_profile_response_model.dart';
import 'package:sierrahilbun/model/verify_otp_screen_model.dart';
import 'package:sierrahilbun/screens/auth/sign_in_screen/model/signin_response_model.dart';
import 'package:sierrahilbun/screens/auth/sign_up_screen/model/sign_up_response_model.dart';
import 'package:sierrahilbun/services/api/api_services.dart';
import 'package:sierrahilbun/utils/app_log/app_log.dart';

class AuthRepository {
  /// Handles the user login API call.
  ///
  /// Takes email and password, calls the generic ApiService,
  /// and returns a parsed [SigninResponseModel].
  /// Throws an exception if the API call fails or returns a non-200 status.
  static Future<SigninResponseModel> login({
    required String email,
    required String password,
  }) async {
    // Define the request body
    final body = {'email': email, 'password': password};

    // Use your generic ApiService to make the POST request
    ApiResponseModel apiResponse = await ApiService.postApi(
      ApiUrls.login,
      body,
    );

    // Check the response status code from your generic handler
    if (apiResponse.statusCode == 200) {
      // Per your ApiService, the full response data is passed as the third
      // parameter to ApiResponseModel. We access it via the `.body` property.
      return SigninResponseModel.fromJson(
        apiResponse.body as Map<String, dynamic>,
      );
    } else {
      // If the API call failed, throw an error with the message from the API
      throw Exception(apiResponse.message);
    }
  }

  /// Handles the user sign-up API call.
  // --- NEW SIGNUP METHOD ---
  static Future<SignUpResponseModel> signUp({
    required String name,
    required String email,
    required String contact,
    required String password,
    required String confirmPassword,
  }) async {
    // Construct the request body to match the Postman request.
    final Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "contact": contact,
      "role": "USER", // Hardcoded as per standard user registration
    };

    try {
      // Call the generic postApi method with the signUp endpoint.
      ApiResponseModel apiResponse = await ApiService.postApi(
        ApiUrls.signUp,
        body,
      );

      // Check if the API call was successful.
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        // Parse the successful response body into our SignUpResponseModel.
        return SignUpResponseModel.fromJson(
          apiResponse.body as Map<String, dynamic>,
        );
      } else {
        // If the API returns a non-success status code, throw an exception with the message from the server.
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog("AuthRepository SignUp Error: $e", source: "Auth Repository");
      // Re-throw the exception to be caught by the controller, cleaning up the message.
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  // Now returns the new model to include the temporary data token.
  static Future<VerifyOtpResponseModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final Map<String, dynamic> body = {
      "email": email,
      "oneTimeCode": int.tryParse(otp) ?? 0,
    };
    try {
      ApiResponseModel apiResponse = await ApiService.postApi(
        ApiUrls.verifyOtp,
        body,
      );
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return VerifyOtpResponseModel.fromJson(
          apiResponse.body as Map<String, dynamic>,
        );
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog("AuthRepository Verify OTP Error: $e", source: "Auth Repository");
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  // --- NEW RESEND OTP METHOD ---
  static Future<OtpResponseModel> resendOtp({required String email}) async {
    // The resend OTP endpoint typically only needs the user's email.
    final Map<String, dynamic> body = {"email": email};

    try {
      ApiResponseModel apiResponse = await ApiService.postApi(
        ApiUrls.resendOtp,
        body,
      );
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return OtpResponseModel.fromJson(
          apiResponse.body as Map<String, dynamic>,
        );
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog("AuthRepository Resend OTP Error: $e", source: "Auth Repository");
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  // --- NEW FORGOT PASSWORD METHOD ---
  static Future<OtpResponseModel> forgotPassword({
    required String email,
  }) async {
    // This API only needs the user's email to send the OTP.
    final Map<String, dynamic> body = {"email": email};

    try {
      ApiResponseModel apiResponse = await ApiService.postApi(
        ApiUrls.forgotPassword,
        body,
      );
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        // We can reuse the OtpResponseModel since the success response is similar.
        return OtpResponseModel.fromJson(
          apiResponse.body as Map<String, dynamic>,
        );
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog(
        "AuthRepository Forgot Password Error: $e",
        source: "Auth Repository",
      );
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  static Future<OtpResponseModel> resetPassword({
    required String token, // This is the temporary token for the header
    required String newPassword,
    required String confirmPassword,
  }) async {
    // 1. The body now ONLY contains the new passwords, as per your Postman details.
    final Map<String, dynamic> body = {
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };

    // 2. A custom header is created to send the temporary token.
    //    The 'Bearer ' prefix has been removed to match your API's requirement.
    final Map<String, String> headers = {'Authorization': token};

    try {
      // 3. The custom header is passed to the ApiService. This will override the
      //    default (empty) token from LocalStorage for this specific request.
      ApiResponseModel apiResponse = await ApiService.postApi(
        ApiUrls.resetPassword,
        body,
        header: headers,
      );

      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return OtpResponseModel.fromJson(
          apiResponse.body as Map<String, dynamic>,
        );
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog(
        "AuthRepository Reset Password Error: $e",
        source: "Auth Repository",
      );
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  // --- NEW CHANGE PASSWORD METHOD (for logged-in users) ---
  static Future<OtpResponseModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    // 1. The body matches your Postman request.
    final Map<String, dynamic> body = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };

    try {
      // 2. Call postApi. The interceptor in your ApiService will automatically
      //    add the 'Authorization: Bearer <token>' header from LocalStorage.
      ApiResponseModel apiResponse = await ApiService.postApi(ApiUrls.changePassword, body);

      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        // We can reuse OtpResponseModel for the success message.
        return OtpResponseModel.fromJson(apiResponse.body as Map<String, dynamic>);
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog("AuthRepository Change Password Error: $e", source: "Auth Repository");
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }


  // --- NEW METHOD TO GET USER PROFILE ---
  static Future<UserProfileResponseModel> getUserProfile() async {
    try {
      // This is a GET request. The interceptor will automatically add the
      // Authorization header since the user has just logged in.
      ApiResponseModel apiResponse = await ApiService.getApi(ApiUrls.userProfile);

      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return UserProfileResponseModel.fromJson(apiResponse.body as Map<String, dynamic>);
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog("AuthRepository GetProfile Error: $e", source: "Auth Repository");
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }
}
