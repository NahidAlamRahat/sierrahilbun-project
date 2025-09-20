class VerifyOtpResponseModel {
  final bool success;
  final String message;
  final String? data; // The temporary token for password reset, can be null.

  VerifyOtpResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "An unknown error occurred.",
      data: json['data'], // This will be the temporary token string.
    );
  }
}
