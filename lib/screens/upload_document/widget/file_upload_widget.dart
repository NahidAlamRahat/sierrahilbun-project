import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dashed_border_painter.dart';

// Alternative FileUploadWidget using ImagePicker


class FileUploadWidget extends StatefulWidget {
  final Function(File?)? onFileSelected;
  final double? maxSizeInMB;
  final String? title;
  final String? subtitle;

  const FileUploadWidget({
    Key? key,
    this.onFileSelected,
    this.maxSizeInMB = 2.0,
    this.title = 'Upload photo',
    this.subtitle = '(Max: 2MB, .jpg, .png)', required List<String> allowedExtensions,
  }) : super(key: key);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  File? _selectedFile;
  bool _isDragging = false;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: _isDragging ? Colors.blue : Colors.grey.shade400,
          strokeWidth: _isDragging ? 2 : 1,
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(12),
          ),
          child: _selectedFile != null
              ? _buildSelectedFileUI()
              : _buildUploadUI(),
        ),
      ),
    );
  }

  Widget _buildUploadUI() {
    return InkWell(
      onTap: () => _showSourceActionSheet(context),
      onHover: (hovering) {
        setState(() {
          _isDragging = hovering;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Upload icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.cloud_upload_outlined,
                size: 32,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              widget.title ?? 'Upload photo',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),

            // Subtitle
            Text(
              widget.subtitle ?? '(Max: 2MB, .jpg, .png)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFileUI() {
    String fileName = _selectedFile!.path.split('/').last;
    String fileExtension = fileName.split('.').last.toLowerCase();
    double fileSizeInMB = _selectedFile!.lengthSync() / (1024 * 1024);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // File preview
          if (['jpg', 'jpeg', 'png'].contains(fileExtension))
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(_selectedFile!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.insert_drive_file,
                size: 48,
                color: Colors.grey.shade600,
              ),
            ),

          const SizedBox(height: 16),

          // File details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${fileSizeInMB.toStringAsFixed(2)} MB',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Remove button
              IconButton(
                onPressed: _removeFile,
                icon: Icon(
                  Icons.close,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Upload progress or success
          if (_isUploading) ...[
            const LinearProgressIndicator(),
            const SizedBox(height: 8),
            const Text(
              'Uploading...',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue,
              ),
            ),
          ] else ...[
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 16,
                ),
                const SizedBox(width: 8),
                const Text(
                  'File selected successfully',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showSourceActionSheet(context),
                  child: const Text('Change File'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isUploading ? null : _uploadFile,
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        File file = File(image.path);
        _validateAndSetFile(file);
      }
    } catch (e) {
      _showErrorDialog('Error', 'Failed to pick image from gallery: $e');
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        File file = File(image.path);
        _validateAndSetFile(file);
      }
    } catch (e) {
      _showErrorDialog('Error', 'Failed to take photo: $e');
    }
  }

  void _validateAndSetFile(File file) {
    // Check file size
    double fileSizeInMB = file.lengthSync() / (1024 * 1024);
    if (fileSizeInMB > (widget.maxSizeInMB ?? 2.0)) {
      _showErrorDialog('File size too large',
          'Please select a file smaller than ${widget.maxSizeInMB} MB');
      return;
    }

    setState(() {
      _selectedFile = file;
    });

    // Callback to parent widget
    if (widget.onFileSelected != null) {
      widget.onFileSelected!(file);
    }
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
    });

    if (widget.onFileSelected != null) {
      widget.onFileSelected!(null);
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) return;

    setState(() {
      _isUploading = true;
    });

    // Simulate upload process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isUploading = false;
    });

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showErrorDialog(String title, String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}