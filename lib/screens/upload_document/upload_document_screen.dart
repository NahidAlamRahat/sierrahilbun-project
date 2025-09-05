import 'package:flutter/material.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/screens/upload_document/widget/file_upload_widget.dart';
import 'package:sierrahilbun/widgets/app_button/app_button.dart';
import 'package:sierrahilbun/widgets/appbar_widget/appbar_widget.dart';

class UploadDocumentScreen extends StatelessWidget {
  UploadDocumentScreen({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
       appBar: AppbarWidget(
         showLeading: false,
         text: 'Upload Document Screen',
       ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Using regular TextFormField instead of custom widget
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Document Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
      
                const SizedBox(height: 20),
      
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter Short Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
      
                const SizedBox(height: 20),
      
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Select Your Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
      
                const SizedBox(height: 20),
      
                TextFormField(
                  controller: controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Detailed Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
      
                const SizedBox(height: 20),
      
                // File Upload Widget
                FileUploadWidget(
                  onFileSelected: (file) {
                    if (file != null) {
                      print('File selected: ${file.path}');
                    } else {
                      print('File removed');
                    }
                  },
                  maxSizeInMB: 2.0,
                  allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                  title: 'Upload photo, PDF',
                  subtitle: '(Max: 2MB, .jpg, .png)',
                ),
      
                const SizedBox(height: 20),
      
                // Using regular ElevatedButton instead of custom AppButton
                AppButton(title: 'Submit',filColor: AppColors.commonButtonColor,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}




