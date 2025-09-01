import 'dart:io' as io;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'dart:typed_data';

class AppwriteService {
  static final AppwriteService _instance = AppwriteService._internal();
  factory AppwriteService() => _instance;
  AppwriteService._internal();

  late Client _client;
  late Storage _storage;

  // Appwrite configuration

  static const String _endpoint = 'https://nyc.cloud.appwrite.io/v1';
  static const String _projectName = 'Arch-Apprive';
  static const String _projectId = '68b52b04000034459cff';
  static const String _bucketId =
      '68b52b2600279af18582'; // Use the bucket name, not the project ID
  static const String _bucketName = "attachments";

  /// Initialize the Appwrite client and storage
  void initialize() {
    _client = Client()
      ..setEndpoint(_endpoint)
      ..setProject(_projectId);

    _storage = Storage(_client);

    print('Appwrite initialized with:');
    print('- Endpoint: $_endpoint');
    print('- Project ID: $_projectId');
    print('- Bucket ID: $_bucketId');
  }

  /// Upload a file to the storage bucket
  /// Returns the file object on success
  Future<File> uploadFile({required io.File file, String? fileName}) async {
    try {
      final String name = fileName ?? file.path.split('/').last;

      print('Uploading file: $name to bucket: $_bucketId');
      print('File path: ${file.path}');
      print('File size: ${file.lengthSync()} bytes');

      final File result = await _storage.createFile(
        bucketId: _bucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path, filename: name),
      );

      print('File uploaded successfully: ${result.$id}');
      return result;
    } catch (e) {
      print('Error uploading file: $e');

      // Provide more specific error messages
      if (e.toString().contains('Invalid Origin')) {
        throw Exception(
          'Appwrite Origin Error: Your app is not registered in Appwrite console. Please add your Android platform (com.example.arch_approve) to your Appwrite project.',
        );
      } else if (e.toString().contains('bucket')) {
        throw Exception(
          'Bucket Error: Check if bucket "$_bucketId" exists in your Appwrite project.',
        );
      } else if (e.toString().contains('permission')) {
        throw Exception(
          'Permission Error: Check if your API key has storage permissions.',
        );
      } else {
        throw Exception('Failed to upload file: $e');
      }
    }
  }

  /// Upload a file with custom file ID
  /// Returns the file object on success
  Future<File> uploadFileWithId({
    required io.File file,
    required String fileId,
    String? fileName,
  }) async {
    try {
      final String name = fileName ?? file.path.split('/').last;

      final File result = await _storage.createFile(
        bucketId: _bucketId,
        fileId: fileId,
        file: InputFile.fromPath(path: file.path, filename: name),
      );

      return result;
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  /// Get file information by file ID
  Future<File> getFile(String fileId) async {
    try {
      return await _storage.getFile(bucketId: _bucketId, fileId: fileId);
    } catch (e) {
      throw Exception('Failed to get file: $e');
    }
  }

  /// Get file download bytes
  Future<Uint8List> getFileDownload(String fileId) async {
    try {
      return await _storage.getFileDownload(
        bucketId: _bucketId,
        fileId: fileId,
      );
    } catch (e) {
      throw Exception('Failed to download file: $e');
    }
  }

  /// Get file preview bytes
  Future<Uint8List> getFilePreview(String fileId) async {
    try {
      return await _storage.getFilePreview(bucketId: _bucketId, fileId: fileId);
    } catch (e) {
      throw Exception('Failed to get file preview: $e');
    }
  }

  /// Get file view bytes
  Future<Uint8List> getFileView(String fileId) async {
    try {
      return await _storage.getFileView(bucketId: _bucketId, fileId: fileId);
    } catch (e) {
      throw Exception('Failed to get file view: $e');
    }
  }

  /// Delete a file from the storage bucket
  Future<void> deleteFile(String fileId) async {
    try {
      await _storage.deleteFile(bucketId: _bucketId, fileId: fileId);
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  /// List all files in the bucket
  Future<FileList> listFiles({List<String>? queries, String? search}) async {
    try {
      return await _storage.listFiles(
        bucketId: _bucketId,
        queries: queries,
        search: search,
      );
    } catch (e) {
      throw Exception('Failed to list files: $e');
    }
  }

  /// Update file name
  Future<File> updateFileName({
    required String fileId,
    required String name,
  }) async {
    try {
      return await _storage.updateFile(
        bucketId: _bucketId,
        fileId: fileId,
        name: name,
      );
    } catch (e) {
      throw Exception('Failed to update file name: $e');
    }
  }
}
