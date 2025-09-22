import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/api_urls.dart';
import 'package:sierrahilbun/model/my_document_response_model.dart';
import 'package:sierrahilbun/widgets/appbar_widget/appbar_widget.dart';

class DocumentDetailScreen extends StatelessWidget {
  const DocumentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Safely get the document passed from the previous screen
    final DocumentItem document = Get.arguments as DocumentItem;
    final String imageUrl = document.documentPaths.isNotEmpty
      ? '${ApiUrls.baseImageUrl}${document.documentPaths.first}'
      : '';

    return Scaffold(
      appBar: const AppbarWidget(
        text: 'View Details',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- First Card: Basic Info ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildDetailRow('Document Title:', document.title),
                    _buildDetailRow('Short Description:', document.sortDescription),
                    _buildDetailRow('Category:', document.category.title),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Second Card: Detailed Description ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Detailed Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      document.detailDescription,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Third Card: Image Preview ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      // Add loading and error builders for a better UX
                      loadingBuilder: (context, child, progress) {
                        return progress == null ? child : const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.error_outline, color: Colors.red, size: 50));
                      },
                    )
                  : const Center(
                      child: Icon(Icons.image_not_supported_outlined, color: Colors.grey, size: 100),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
