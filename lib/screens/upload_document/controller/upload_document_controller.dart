import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sierrahilbun/model/category_response_model.dart';
import 'package:sierrahilbun/services/repository/upload_document/document_repository.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class UploadDocumentController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Use separate controllers for each field
  late TextEditingController titleController;
  late TextEditingController shortDescController;
  late TextEditingController detailedDescController;

  var isLoading = false.obs;
  var isFetchingCategories = true.obs;

  // For the category dropdown
  var categories = <CategoryItem>[].obs;
  var selectedCategory = Rxn<CategoryItem>();

  // For the selected file (image)
  var selectedFile = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    shortDescController = TextEditingController();
    detailedDescController = TextEditingController();
    fetchCategories();
  }

  @override
  void onClose() {
    titleController.dispose();
    shortDescController.dispose();
    detailedDescController.dispose();
    super.onClose();
  }

  /// Fetches categories from the API to populate the dropdown.
  Future<void> fetchCategories() async {
    try {
      isFetchingCategories.value = true;
      var fetchedCategories = await DocumentRepository.getCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isFetchingCategories.value = false;
    }
  }

  /// Opens the image gallery to select a document.
  Future<void> pickImage() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedFile.value = File(image.path);
      }
    } else {
      AppSnackBar.message("Photo access is required to select a document.");
    }
  }

  void removeFile() {
    selectedFile.value = null;
  }

  /// Submits the document and its details to the server.
  Future<void> submitDocument() async {
    if (formKey.currentState?.validate() ?? false) {
      if (selectedFile.value == null) {
        AppSnackBar.error("Please select a document to upload.");
        return;
      }

      isLoading.value = true;
      try {
        final response = await DocumentRepository.uploadDocument(
          title: titleController.text,
          sortDescription: shortDescController.text,
          detailDescription: detailedDescController.text,
          categoryId: selectedCategory.value!.id,
          filePath: selectedFile.value!.path,
        );
        AppSnackBar.success(response.message);
        //Clear the form after successful submission
        titleController.clear();
        shortDescController.clear();
        detailedDescController.clear();
        selectedCategory.value = null;
        selectedFile.value = null;
      } catch (e) {
        AppSnackBar.error(e.toString());
      } finally {
        if (!isClosed) {
          isLoading.value = false;
        }
      }
    }
  }
}
