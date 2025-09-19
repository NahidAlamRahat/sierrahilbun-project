import 'package:sierrahilbun/constants/api_urls.dart';
import 'package:sierrahilbun/model/api_response_model.dart';
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
}
