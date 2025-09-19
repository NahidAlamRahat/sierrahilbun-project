class SigninResponseModel {
  final bool success;
  final String message;
  final LoginData data;

  SigninResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SigninResponseModel.fromJson(Map<String, dynamic> json) {
    return SigninResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "An unknown error occurred",
      data: LoginData.fromJson(json['data']),
    );
  }
}

class LoginData {
  final String accessToken;
  final String refreshToken;

  LoginData({required this.accessToken, required this.refreshToken});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      accessToken: json['accessToken'] ?? "",
      refreshToken: json['refreshToken'] ?? "",
    );
  }
}
