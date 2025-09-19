// class ApiUrls {
//   static const String baseUrl = "10.10.7.46:5001/api/v1";
//   static const String imageUrl = "10.10.7.46:5001/api";

//   static const String login = "$baseUrl/auth/login";
// }

class ApiUrls {
  // 1. Added the http:// protocol
  // 2. Ensured it ends with a slash for clean joining
  static const String baseUrl = "http://10.10.7.46:5001/api/v1/";

  // Image URL corrected as well
  static const String imageUrl = "http://10.10.7.46:5001/api";

  // The endpoint should ONLY be the path, not the full URL
  static const String login = "auth/login";
}
