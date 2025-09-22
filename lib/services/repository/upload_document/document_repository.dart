import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sierrahilbun/constants/api_urls.dart';
import 'package:sierrahilbun/model/api_response_model.dart';
import 'package:sierrahilbun/model/category_response_model.dart';
import 'package:sierrahilbun/model/upload_document_response_model.dart';
import 'package:sierrahilbun/services/api/api_services.dart';
import 'package:sierrahilbun/utils/app_log/app_log.dart';

class DocumentRepository {
  /// Fetches the list of document categories from the API.
  static Future<List<CategoryItem>> getCategories() async {
    try {
      ApiResponseModel apiResponse = await ApiService.getApi(ApiUrls.getCategories);
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        // Corrected: Explicitly cast the body to the expected type.
        return CategoryResponseModel.fromJson(apiResponse.body as Map<String, dynamic>).data;
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog("Get Categories Error: $e", source: "DocumentRepository");
      throw Exception("Failed to load categories.");
    }
  }

  /// Uploads a new document with its details.
  static Future<UploadDocumentResponseModel> uploadDocument({
    required String title,
    required String sortDescription,
    required String detailDescription,
    required String categoryId,
    required String filePath, // This is the path to the selected image
  }) async {
    final file = File(filePath);
    final fileName = file.path.split('/').last;

    // Create the multipart form data to match your Postman request
    final formData = FormData.fromMap({
      'title': title,
      'sortDescription': sortDescription,
      'detailDescription': detailDescription,
      'category': categoryId,
      'document': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try {
      // Use postApi, which will be handled by your ApiService
      ApiResponseModel apiResponse = await ApiService.postApi(
        ApiUrls.uploadDocument,
        formData,
      );
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        // Corrected: Explicitly cast the body to the expected type.
        return UploadDocumentResponseModel.fromJson(apiResponse.body as Map<String, dynamic>);
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      appLog("Upload Document Error: $e", source: "DocumentRepository");
      throw Exception("Failed to upload document.");
    }
  }
}

