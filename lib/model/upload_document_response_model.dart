// This model is for the success response after uploading a document.
class UploadDocumentResponseModel {
  final bool success;
  final String message;

  UploadDocumentResponseModel({required this.success, required this.message});

  factory UploadDocumentResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadDocumentResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "An unknown error occurred.",
    );
  }
}
