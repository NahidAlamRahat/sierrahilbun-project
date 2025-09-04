/*
import 'dart:io';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

import '../../../constants/api_urls.dart';
import '../../../models/profile_model.dart';
import '../../../utils/app_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../api/api_services.dart';

class ProfileRepository {
  Future<Profile?> fetchProfile() async {
    try {
      var response = await ApiService.getApi(ApiUrls.profile);
      if (response.body["data"] != null && response.body["data"] is Map) {
        return Profile.fromJson(response.body["data"]);
      }
      return null;
    } catch (e) {
      errorLog(
        e,
        source: "fetchProfile repo function",
      );
      return null;
    }
  }

  ///update Profile Repository

  Future<bool> updateProfile({
    String? name,
    String? lastName,
    List<double>? location,
    File? imageFile,
  }) async {
    try {
      final Map<String, dynamic> data = {};
      if (name != null && name.trim().isNotEmpty) {
        data["name"] = name;
      }
      if (lastName != null && lastName.trim().isNotEmpty) {
        data["lastName"] = lastName;
      }
      if (location != null && location.isNotEmpty) {
        data["location"] = {"type": "Point", "coordinates": location};
      }
      if (imageFile != null) {
        data["image"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: "profile.jpg",
          contentType: MediaType("image", "jpg"),
        );
      }

      FormData formData = FormData.fromMap(data);

      errorLog(formData.fields, source: "FormData being sent");

       await ApiService.patchApi(
        ApiUrls.updateProfile,
        body: formData,
      );

      AppSnackBar.success("Profile updated successfully.");
      return true;
        } catch (e) {
      errorLog(e, source: "updateProfile error");
      AppSnackBar.error("An error occurred while updating the profile.");
      return false;
    }
  }

}
*/
