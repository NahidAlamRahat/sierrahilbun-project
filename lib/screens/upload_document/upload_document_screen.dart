import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/screens/upload_document/controller/upload_document_controller.dart';
import 'package:sierrahilbun/screens/upload_document/widget/file_upload_widget.dart';
import 'package:sierrahilbun/widgets/app_button/app_button.dart';
import 'package:sierrahilbun/widgets/appbar_widget/appbar_widget.dart';

class UploadDocumentScreen extends StatelessWidget {
  UploadDocumentScreen({super.key});

  final UploadDocumentController controller = Get.put(
    UploadDocumentController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        centerTitle: true,
        showLeading: false, // Allow user to go back
        text: 'Upload Document',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Document Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) =>
                      (value ?? "").isEmpty ? 'Title is required' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.shortDescController,
                  decoration: InputDecoration(
                    hintText: 'Enter Short Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => (value ?? "").isEmpty
                      ? 'Short description is required'
                      : null,
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (controller.isFetchingCategories.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DropdownButtonFormField(
                    value: controller.selectedCategory.value,
                    hint: const Text('Select Your Category'),
                    items: controller.categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedCategory.value = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) =>
                        value == null ? 'Category is required' : null,
                  );
                }),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.detailedDescController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Detailed Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => (value ?? "").isEmpty
                      ? 'Detailed description is required'
                      : null,
                ),
                const SizedBox(height: 20),
                Obx(
                  () => FileUploadWidget(
                    file: controller.selectedFile.value,
                    onFileSelected: controller.pickImage, // Corrected callback
                    onFileRemoved: controller.removeFile,
                    maxSizeInMB: 2.0,
                    allowedExtensions: const [
                      'jpg',
                      'jpeg',
                      'png',
                    ], // As per request
                    title: 'Upload photo',
                    subtitle: '(Max: 2MB, .jpg, .png)',
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.commonButtonColor,
                          ),
                        )
                      : AppButton(
                          title: 'Submit',
                          filColor: AppColors.commonButtonColor,
                          onTap: controller.submitDocument,
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
