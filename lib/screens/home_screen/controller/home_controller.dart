import 'dart:async';
import 'package:get/get.dart';
import 'package:sierrahilbun/model/my_document_response_model.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/upload_document/document_repository.dart';
import 'package:sierrahilbun/services/storage/storage_service.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class HomeController extends GetxController {
  // For the 'double click to exit' functionality
  DateTime? lastBackPressTime;

  // --- New reactive variables for the UI state ---
  var isLoading = true.obs;
  var recentDocuments = <DocumentItem>[].obs;

  // Reactive variables for the header UI to make it more robust
  var userName = ''.obs;
  var userImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchRecentDocuments();
  }

  /// Loads user info from storage into reactive variables for the header.
  void loadUserData() {
    userName.value = LocalStorage.myName;
    userImageUrl.value = LocalStorage.myImage;
  }

  /// Fetches all documents, filters them for the current user, sorts by date,
  /// and takes the most recent three.
  Future<void> fetchRecentDocuments() async {
    try {
      isLoading.value = true;
      // 1. Fetch the complete list of documents using the existing repository method.
      final allDocuments = await DocumentRepository.getMyDocuments();
      
      // 2. Get the current user's email to filter the list.
      final currentUserEmail = LocalStorage.myEmail;

      // 3. Filter, sort, and take the top 3.
      var userDocuments = allDocuments
          .where((doc) => doc.user.email == currentUserEmail)
          .toList();

      // Sort the list so the newest documents are first.
      userDocuments.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Take the first 3 documents, or fewer if the user has less than 3.
      recentDocuments.value = userDocuments.take(3).toList();

    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigates to the detail screen, passing the selected document.
  void navigateToDetail(DocumentItem document) {
    Get.toNamed(AppRoutes.documentDetailScreen, arguments: document);
  }

  /// Handles the 'double press back button to exit' logic.
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = lastBackPressTime == null ||
        currentTime.difference(lastBackPressTime!) > const Duration(seconds: 2);
    if (backButton) {
      lastBackPressTime = currentTime;
      AppSnackBar.message('Double click to exit app');
      return false;
    }
    return true;
  }
}
