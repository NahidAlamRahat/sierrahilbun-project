import 'package:sierrahilbun/constants/api_urls.dart';
import 'package:sierrahilbun/model/api_response_model.dart';
import 'package:sierrahilbun/screens/auth/sign_in_screen/model/signin_response_model.dart';
import 'package:sierrahilbun/services/api/api_services.dart';

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
}
