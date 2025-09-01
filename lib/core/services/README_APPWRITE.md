# Appwrite Storage Service

This service provides file upload and management functionality using Appwrite's storage bucket.

## Configuration

The service is configured with the following settings:

- **Endpoint**: `https://cloud.appwrite.io/v1`
- **Project ID**: `68b52b2600279af18582`
- **Bucket ID**: `attachments`

## Setup

1. Add the Appwrite dependency to your `pubspec.yaml`:

```yaml
dependencies:
  appwrite: ^13.0.1
```

2. Initialize the service in your app:

```dart
final appwriteService = AppwriteService();
appwriteService.initialize();
```

## Usage

### Upload a File

```dart
import 'dart:io' as io;
import 'package:your_app/core/services/appwrite_service.dart';

final appwriteService = AppwriteService();
appwriteService.initialize();

// Upload file with auto-generated ID
File uploadedFile = await appwriteService.uploadFile(
  file: io.File('path/to/your/file.pdf'),
  fileName: 'document.pdf',
);

// Upload file with custom ID
File uploadedFile = await appwriteService.uploadFileWithId(
  file: io.File('path/to/your/file.pdf'),
  fileId: 'custom-file-id',
  fileName: 'document.pdf',
);
```

### Get File Information

```dart
// Get file details
final file = await appwriteService.getFile('file-id');
print('File name: ${file.name}');
print('File ID: ${file.$id}');

// Get file bytes for download/preview/view
Uint8List downloadBytes = await appwriteService.getFileDownload('file-id');
Uint8List previewBytes = await appwriteService.getFilePreview('file-id');
Uint8List viewBytes = await appwriteService.getFileView('file-id');
```

### List Files

```dart
// List all files
final fileList = await appwriteService.listFiles();

// Search files
final searchResults = await appwriteService.listFiles(
  search: 'document',
);

// Use queries for filtering
final filteredFiles = await appwriteService.listFiles(
  queries: [
    Query.equal('name', 'document.pdf'),
  ],
);
```

### Update File Name

```dart
final updatedFile = await appwriteService.updateFileName(
  fileId: 'file-id',
  name: 'new-name.pdf',
);
```

### Delete File

```dart
await appwriteService.deleteFile('file-id');
```

## Error Handling

The service includes proper error handling and will throw exceptions with descriptive messages:

```dart
try {
  String fileUrl = await appwriteService.uploadFile(
    file: file,
    fileName: 'test.pdf',
  );
  print('Upload successful: $fileUrl');
} catch (e) {
  print('Upload failed: $e');
}
```

## Example Integration

The service is integrated into the Apply Leave screen with GetX controller. See:

- `lib/presentation/controllers/apply_leave_controller.dart` - GetX controller with file upload logic
- `lib/presentation/screens/apply_leaves/apply_leaves_screen.dart` - UI with Gmail-like attachment functionality

## Important Notes

1. **Authentication**: This service is configured for public bucket access. If you need authenticated access, you'll need to add authentication configuration.

2. **File Types**: The bucket accepts all file types by default. You may want to add file type validation in your app.

3. **File Size**: Check Appwrite's storage limits for your plan.

4. **Security**: Consider implementing proper security rules in your Appwrite console for the storage bucket.

## Troubleshooting

- **Connection Issues**: Ensure your internet connection is stable
- **Permission Errors**: Check if the bucket is properly configured in Appwrite console
- **File Not Found**: Verify the file ID exists in the bucket
