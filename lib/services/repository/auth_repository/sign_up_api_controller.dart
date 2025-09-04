/*

import 'package:get/get.dart';
import '../../../constants/api_urls.dart';
import '../../../utils/app_log/app_log.dart';
import '../../api/api_services.dart';

class SignUpApiController extends GetxController {
  bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;
  String? get successfullyMessage => _successfullyMessage;

  Future<bool> userSignUp(var signUpModel) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();

    var response = await ApiService.postApi(
      ApiUrls.createUserAccount,
      signUpModel,
    );

    if (response.statusCode == 200) {
      _successfullyMessage = response.message;
      isSuccess = true;
    } else {
      _errorMessage = response.message;
    }

    _signUpInProgress = false;
    update();
    return isSuccess;
  }
}
*/
