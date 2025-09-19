class SignUpResponseModel {
  final bool success;
  final String message;

  SignUpResponseModel({required this.success, required this.message});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "An unknown error occurred.",
    );
  }
}
