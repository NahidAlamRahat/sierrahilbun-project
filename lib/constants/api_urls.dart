
// String _getDomain() {
//   String serverDomain =
//       "https://divx-rare-realtor-immune.trycloudflare.com"; //////////// live server
//   String localDomain = "https://divx-rare-realtor-immune.trycloudflare.com"; ///////// local server
//   try {
//     if (kReleaseMode) {
//       return serverDomain;
//     } else {
//       return localDomain;
//     }
//   } catch (e) {
//     errorLog("_getDomain",);
//     return serverDomain;
//   }
// }


class ApiUrls {
  // instance variable
  String id;


  // constructor
  ApiUrls({this.id = ''});

  // base url
  // static final String domain = _getDomain();
  // static const String baseUrl = "https://perceived-bare-wholesale-lives.trycloudflare.com/api/v1";
  static const String baseUrl = "https://asad.binarybards.online/api/v1";
  static const String domain = "https://asad.binarybards.online";

  static const String imageUrl = "https://asad.binarybards.online";

  // auth urls
  static String login = "$baseUrl/auth/login";
  static const String createUserAccount = "$baseUrl/user/create-user";
  static const String verifyEmail = "$baseUrl/auth/verify-account/";
  static const String resendOtp = "$baseUrl/auth/resend-otp";
  static const String refreshToken = "$baseUrl/auth/refresh-token";
  static const String forgotPassword = "$baseUrl/auth/forget-password";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String changePassword = "$baseUrl/auth/change-password";
  static const String profile = "/user/profile";
  static const String updateProfile = "/user/profile";

  // category urls
  static const String categories = "$baseUrl/category/";
  static const String subCategories = "$baseUrl/subcategory/";
  static const String createOffer = "$baseUrl/offer/";
  static const String getAllOffer = "$baseUrl/offer/";
  static const String updateOffer = "$baseUrl/offer/";
  static const String deleteOffer = "$baseUrl/offer/";
  static const String supportUrl = "$baseUrl/support/";

  // Common urls
  static const String faq = "/public/faq/all";
  static const String termsAndCondition = "/public/terms-and-condition";
  static const String about = "/public/about-us";


  static const String createRequest = "$baseUrl/request/create-request";
  static const String getRequestUrl = "$baseUrl/request";

  static String  bookingSuccessUrl ({required String bookingId}) => "$baseUrl/booking/$bookingId";

  static String  bookingGrowthUrl ({required String status}) => "$baseUrl/booking/conversion-growth?$status-${DateTime.now().year}";

  static String  userGrowthUrl ({required String status}) => "$baseUrl/booking/growth?$status-${DateTime.now().year}";

 static String  userChatUrl({required String requestId}) => "$baseUrl/chat/user/$requestId";

  static String  messageUrl({required String chatId}) => "$baseUrl/message/$chatId";

  static const String bookingCreateUrl = "$baseUrl/booking/";

  static const String userNotificationsUrl = "$baseUrl/notifications";
  static const String readUserNotificationsUrl = "$baseUrl/notifications/all";


  static String businessChatListUrl({required String status}) => "$baseUrl/chat/businesses?status=$status";







}
