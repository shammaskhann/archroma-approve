import 'dart:developer';
import 'dart:io' as io;
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:arch_approve/core/services/firebase/leave_services.dart';
import 'package:arch_approve/core/services/appwrite_service.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';

class ApplyLeaveController extends GetxController {
  final FirebaseLeavesService _firebaseLeavesService = FirebaseLeavesService();
  final AppwriteService _appwriteService = AppwriteService();

  // Form fields
  final RxString selectedLeaveType = ''.obs;
  final RxString deductForm = ''.obs;
  final RxString startDate = ''.obs;
  final RxString endDate = ''.obs;
  final RxString reason = ''.obs;
  final RxString description = ''.obs;

  // Single file attachment
  final Rxn<io.File> selectedFile = Rxn<io.File>();
  final Rxn<Map<String, dynamic>> uploadedFile = Rxn<Map<String, dynamic>>();
  final RxBool isUploading = false.obs;
  final RxBool isSubmitting = false.obs;

  final RxString selectedLeaveDuration = ''.obs;
  final RxBool shouldDeduct = true.obs;

  void setLeaveDuration(String label, bool deduct) {
    selectedLeaveDuration.value = label;
    shouldDeduct.value = deduct;

    // Reset dates if needed
    if (label == 'Half Day' || label == 'Full Day') {
      endDate.value = startDate.value;
    }
  }

  // Error handling
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize Appwrite service for file uploads
    _appwriteService.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    resetForm();
  }

  /// Pick a single file for attachment
  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, // only one file
        type: FileType.any,
      );

      if (result != null && result.files.single.path != null) {
        selectedFile.value = io.File(result.files.single.path!);
      }
    } catch (e) {
      errorMessage.value = 'Error picking file: $e';
    }
  }

  /// Remove selected file
  void removeSelectedFile() {
    selectedFile.value = null;
  }

  /// Remove uploaded file
  void removeUploadedFile() {
    uploadedFile.value = null;
  }

  /// Upload selected file to Appwrite
  Future<void> uploadFile() async {
    if (selectedFile.value == null) return;

    isUploading.value = true;
    errorMessage.value = '';

    try {
      final file = selectedFile.value!;
      final fileName = file.path.split('/').last;

      // Upload file to Appwrite
      final uploaded = await _appwriteService.uploadFile(
        file: file,
        fileName: fileName,
      );

      uploadedFile.value = {
        'fileId': uploaded.$id,
        'fileName': uploaded.name,
        'fileSize': uploaded.sizeOriginal,
        'uploadedAt': DateTime.now().toIso8601String(),
        'appwriteBucketId':
            'attachments', // Store bucket ID for future reference
      };

      // Clear selected file after upload
      selectedFile.value = null;
    } catch (e) {
      errorMessage.value = 'Error uploading file: $e';
      log(errorMessage.value);
      // Note: This method needs BuildContext to show SnackBar
      // Consider moving this logic to the UI layer or using a different approach
    } finally {
      isUploading.value = false;
    }
  }

  /// Submit leave application
  Future<void> submitLeaveApplication() async {
    if (!validateForm()) {
      // Note: This method needs BuildContext to show SnackBar
      // Consider moving this logic to the UI layer or using a different approach
      return;
    }

    isSubmitting.value = true;
    errorMessage.value = '';

    try {
      // Upload file if selected but not uploaded yet
      if (selectedFile.value != null) {
        await uploadFile();
      }
      int leaveDays = 0;
      if (shouldDeduct.value) {
        DateTime start = DateTime.parse(startDate.value);
        DateTime end = DateTime.parse(endDate.value);
        leaveDays = end.difference(start).inDays + 1;
      } else {
        leaveDays = 0; // Half day — no deduction
      }

      // Pass `leaveDays` to backend or use in logic

      // Submit to Firebase using the leaves service
      final leaveId = await _firebaseLeavesService
          .createLeaveApplicationWithUser(
            leaveType: selectedLeaveType.value,
            startDate: startDate.value,
            endDate: endDate.value,
            reason: reason.value,
            description: description.value,
            attachment: uploadedFile.value,
            leaveDuration: selectedLeaveDuration.value,
            shouldDeduct: shouldDeduct.value,
            deductForm: deductForm.value,
          );

      print('Leave Application submitted with ID: $leaveId');

      // Note: This method needs BuildContext to show SnackBar
      // Consider moving this logic to the UI layer or using a different approach

      resetForm();
      // Get.back();
    } catch (e) {
      errorMessage.value = 'Error submitting application: $e';
      // Note: This method needs BuildContext to show SnackBar
      // Consider moving this logic to the UI layer or using a different approach
      resetForm();
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Set leave type
  void setLeaveType(String type) {
    selectedLeaveType.value = type;
  }

  void setDeductForm(String deduct) {
    deductForm.value = deduct;
  }

  /// Set start date
  void setStartDate(String date) {
    startDate.value = date;
  }

  /// Set end date
  void setEndDate(String date) {
    endDate.value = date;
  }

  /// Set reason
  void setReason(String text) {
    reason.value = text;
  }

  /// Set description
  void setDescription(String text) {
    description.value = text;
  }

  /// Reset form
  void resetForm() {
    selectedLeaveType.value = '';
    startDate.value = '';
    endDate.value = '';
    reason.value = '';
    description.value = '';
    selectedFile.value = null;
    uploadedFile.value = null;
    errorMessage.value = '';
  }

  /// Validate form
  bool validateForm() {
    if (selectedLeaveType.value.isEmpty) {
      errorMessage.value = 'Please select a leave type';
      return false;
    }
    if (startDate.value.isEmpty) {
      errorMessage.value = 'Please select start date';
      return false;
    }
    if (endDate.value.isEmpty) {
      errorMessage.value = 'Please select end date';
      return false;
    }
    if (reason.value.isEmpty) {
      errorMessage.value = 'Please provide a reason';
      return false;
    }
    return true;
  }

  /// Get file size in readable format
  String getFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
