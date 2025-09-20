import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sierrahilbun/constants/api_urls.dart';
import 'package:sierrahilbun/model/api_response_model.dart';
import 'package:sierrahilbun/screens/profile_section/chnage_profile_info/model/update_profile_model.dart';
import 'package:sierrahilbun/services/api/api_services.dart';
import 'package:sierrahilbun/utils/app_log/app_log.dart';

class ProfileRepository {
  static Future<UpdateProfileResponseModel> updateProfile({
    required String name,
    required String contact,
    required String location,
    String? imagePath, // The local path to the new image file
  }) async {
    // 1. Create a FormData object to handle file uploads.
    final formData = FormData.fromMap({
      'name': name,
      'contact': contact,
      'location': location,
    });

    // 2. If a new image is selected, add it to the FormData.
    if (imagePath != null && imagePath.isNotEmpty) {
      final file = File(imagePath);
      final fileName = file.path.split('/').last;
      formData.files.add(
        MapEntry(
          'image', // This key must match the API's expected key for the file
          await MultipartFile.fromFile(file.path, filename: fileName),
        ),
      );
    }

    try {
      // 3. We use the PATCH method for updating, which is common for partial updates.
      //    We pass the FormData object as the body.
      //    The Dio interceptor will automatically handle the Bearer token.
      ApiResponseModel apiResponse = await ApiService.patchApi(
        ApiUrls.updateUserProfile,
        body: formData,
      );

      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return UpdateProfileResponseModel.fromJson(
          apiResponse.body as Map<String, dynamic>,
        );
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog(
        "ProfileRepository Update Error: $e",
        source: "Profile Repository",
      );
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }
}
