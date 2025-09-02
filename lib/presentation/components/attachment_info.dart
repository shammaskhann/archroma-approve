import 'dart:io';
import 'package:arch_approve/core/services/appwrite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Widget buildAttachmentInfo(Map<String, dynamic> attachment) {
  return GestureDetector(
    onTap: () => _downloadAndOpenFile(attachment),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.attach_file, color: Colors.blue.shade600, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment['fileName'] ?? 'Attachment',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (attachment['fileSize'] != null)
                  Text(
                    _formatFileSize(attachment['fileSize']),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.download, size: 20, color: Colors.blue.shade600),
        ],
      ),
    ),
  );
}

String _formatFileSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}

Future<void> _downloadAndOpenFile(Map<String, dynamic> attachment) async {
  try {
    // Show loading indicator
    final scaffoldMessenger = ScaffoldMessenger.of(Get.context!);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('Downloading ${attachment['fileName']}...'),
        duration: const Duration(seconds: 2),
      ),
    );

    // Get the file ID from attachment (assuming you stored fileId in the attachment map)
    final String fileId = attachment['fileId'] ?? attachment['id'];

    if (fileId.isEmpty) {
      throw Exception('File ID not found');
    }

    // Initialize Appwrite service if not already done
    final appwriteService = AppwriteService();
    appwriteService.initialize();

    // Download file bytes
    final Uint8List fileBytes = await appwriteService.getFileDownload(fileId);

    // Get temporary directory
    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = '${tempDir.path}/${attachment['fileName']}';

    // Write file to temporary storage
    final File file = File(filePath);
    await file.writeAsBytes(fileBytes);

    // Open the file with the appropriate application
    final result = await OpenFile.open(filePath);

    if (result.type != ResultType.done) {
      throw Exception('Failed to open file: ${result.message}');
    }

    // Show success message
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('File downloaded successfully!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  } catch (e) {
    // Show error message
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('Download failed: ${e.toString()}'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
    print('Error downloading file: $e');
  }
}
