import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/widgets/text_widget/text_widgets.dart';

class FileUploadWidget extends StatelessWidget {
  final File? file;
  final VoidCallback onFileSelected;
  final VoidCallback onFileRemoved;
  final double maxSizeInMB;
  final List<String> allowedExtensions;
  final String title;
  final String subtitle;

  const FileUploadWidget({
    super.key,
    required this.file,
    required this.onFileSelected,
    required this.onFileRemoved,
    this.maxSizeInMB = 2.0,
    this.allowedExtensions = const ['jpg', 'png', 'pdf'],
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return file == null ? _buildPicker() : _buildPreview();
  }

  /// The widget state when no file is selected.
  Widget _buildPicker() {
    return GestureDetector(
      onTap: onFileSelected,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 48,
                color: AppColors.commonButtonColor,
              ),
              const SizedBox(height: 8),
              TextWidget(text: title, fontWeight: FontWeight.w600),
              const SizedBox(height: 4),
              TextWidget(
                text: subtitle,
                fontSize: 12,
                fontColor: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The widget state when a file has been selected.
  Widget _buildPreview() {
    final fileName = file!.path.split('/').last;
    final isImage = [
      'jpg',
      'jpeg',
      'png',
    ].any((ext) => fileName.toLowerCase().endsWith(ext));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.commonButtonColor, width: 1),
      ),
      child: Row(
        children: [
          // File Icon
          isImage
              ? Image.file(file!, width: 48, height: 48, fit: BoxFit.cover)
              : const Icon(Icons.picture_as_pdf, size: 48, color: Colors.red),
          const SizedBox(width: 16),
          // File Name
          Expanded(
            child: Text(
              fileName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 16),
          // Remove Button
          IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.red),
            onPressed: onFileRemoved,
          ),
        ],
      ),
    );
  }
}
