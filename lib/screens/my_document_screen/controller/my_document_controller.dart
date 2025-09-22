import 'package:get/get.dart';
import 'package:sierrahilbun/model/my_document_response_model.dart';
import 'package:sierrahilbun/routes/app_routes.dart';
import 'package:sierrahilbun/services/repository/upload_document/document_repository.dart';
import 'package:sierrahilbun/services/storage/storage_service.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class MyDocumentController extends GetxController {
  var isLoading = true.obs;
  var myDocuments = <DocumentItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyDocuments();
  }

  /// Fetches all documents and filters them for the current user.
  Future<void> fetchMyDocuments() async {
    try {
      isLoading.value = true;
      // 1. Fetch the complete list of documents from the repository.
      final allDocuments = await DocumentRepository.getMyDocuments();
      
      // 2. Get the current user's email from your LocalStorage service.
      final currentUserEmail = LocalStorage.myEmail;

      // 3. Filter the list to include only documents where the user's email matches.
      myDocuments.value = allDocuments
          .where((doc) => doc.user.email == currentUserEmail)
          .toList();

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
}
