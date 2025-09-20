class UpdateProfileResponseModel {
  final bool success;
  final String message;
  final UserProfileData? data;

  UpdateProfileResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null ? UserProfileData.fromJson(json['data']) : null,
    );
  }
}

class UserProfileData {
  final String id;
  final String name;
  final String role;
  final String email;
  final String? contact;
  final String? profileImage;
  final String? location;

  UserProfileData({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    this.contact,
    this.profileImage,
    this.location,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      id: json['_id'],
      name: json['name'],
      role: json['role'],
      email: json['email'],
      contact: json['contact'],
      profileImage: json['profile'],
      location: json['location'],
    );
  }
}