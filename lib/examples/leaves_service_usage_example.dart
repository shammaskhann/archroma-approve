import 'package:arch_approve/core/services/firebase/leave_services.dart';
import 'package:arch_approve/data/repositories/firebase_leaves_repository_impl.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:arch_approve/data/models/User_Model.dart';

/// Example usage of the Firebase Leaves Service and Repository
/// This file demonstrates how to use the leave management system
class LeavesServiceUsageExample {
  /// Example of how to submit a leave application
  static Future<void> submitLeaveExample() async {
    try {
      // Create the service instance
      final leavesService = FirebaseLeavesService();

      // Submit a leave application with current user data
      final leaveId = await leavesService.createLeaveApplicationWithUser(
        leaveType: 'Annual Leave',
        startDate: '2024-01-15',
        endDate: '2024-01-17',
        reason: 'Family vacation',
        description: 'Taking time off for family vacation',
        attachment: {
          'fileId': 'appwrite_file_id_123',
          'fileName': 'vacation_request.pdf',
          'fileSize': 1024000,
          'uploadedAt': DateTime.now().toIso8601String(),
          'appwriteBucketId': 'attachments',
        },
      );

      print('Leave application submitted successfully with ID: $leaveId');
    } catch (e) {
      print('Error submitting leave application: $e');
    }
  }

  /// Example of how to get user's leave applications
  static Future<void> getUserLeavesExample(String uid) async {
    try {
      final leavesService = FirebaseLeavesService();

      // Get all leaves for a specific user
      final userLeaves = await leavesService.getUserLeaves(uid);

      print('User has ${userLeaves.length} leave applications:');
      for (final leave in userLeaves) {
        print(
          '- ${leave.leaveType}: ${leave.statusDisplayText} (${leave.startDate} to ${leave.endDate})',
        );
      }
    } catch (e) {
      print('Error getting user leaves: $e');
    }
  }

  /// Example of how to approve/reject a leave application
  static Future<void> approveLeaveExample(
    String leaveId,
    String approverName,
  ) async {
    try {
      final leavesService = FirebaseLeavesService();

      // Approve a leave application
      await leavesService.updateLeaveStatus(
        leaveId,
        LeaveStatus.accepted,
        approvedBy: approverName,
      );

      print('Leave application approved successfully');
    } catch (e) {
      print('Error approving leave application: $e');
    }
  }

  /// Example of how to reject a leave application
  static Future<void> rejectLeaveExample(
    String leaveId,
    String rejectionReason,
  ) async {
    try {
      final leavesService = FirebaseLeavesService();

      // Reject a leave application
      await leavesService.updateLeaveStatus(
        leaveId,
        LeaveStatus.rejected,
        rejectionReason: rejectionReason,
      );

      print('Leave application rejected successfully');
    } catch (e) {
      print('Error rejecting leave application: $e');
    }
  }

  /// Example of how to get leave statistics
  static Future<void> getLeaveStatsExample(String uid) async {
    try {
      final leavesService = FirebaseLeavesService();

      // Get leave statistics for a user
      final stats = await leavesService.getUserLeaveStats(uid);

      print('Leave Statistics:');
      print('- Pending: ${stats['pending']}');
      print('- Accepted: ${stats['accepted']}');
      print('- Rejected: ${stats['rejected']}');
      print('- Total: ${stats['total']}');
    } catch (e) {
      print('Error getting leave statistics: $e');
    }
  }

  /// Example of how to use the repository pattern
  static Future<void> repositoryPatternExample() async {
    try {
      // Create the repository implementation
      final leavesRepository = FirebaseLeavesRepositoryImpl(
        FirebaseLeavesService(),
      );

      // Use the repository to get pending leaves
      final pendingLeaves = await leavesRepository.getPendingLeaves();

      print('There are ${pendingLeaves.length} pending leave applications');

      // Use the repository to get all leaves
      final allLeaves = await leavesRepository.getAllLeaves();

      print('Total leave applications in system: ${allLeaves.length}');
    } catch (e) {
      print('Error using repository pattern: $e');
    }
  }

  /// Example of how to stream leave applications
  static void streamLeavesExample(String uid) {
    final leavesService = FirebaseLeavesService();

    // Stream user's leave applications
    leavesService
        .streamUserLeaves(uid)
        .listen(
          (leaves) {
            print(
              'User has ${leaves.length} leave applications (real-time update)',
            );
            for (final leave in leaves) {
              print('- ${leave.leaveType}: ${leave.statusDisplayText}');
            }
          },
          onError: (error) {
            print('Error streaming leaves: $error');
          },
        );
  }

  /// Example of how to create a leave application manually
  static Future<void> createLeaveManuallyExample() async {
    try {
      final leavesService = FirebaseLeavesService();

      // Create a leave model manually
      final leave = LeaveModel(
        leaveType: 'Sick Leave',
        startDate: '2024-01-20',
        endDate: '2024-01-21',
        reason: 'Not feeling well',
        description: 'Need to rest due to illness',
        status: LeaveStatus.pending,
        user: UserModel(
          name: 'John Doe',
          email: 'john.doe@example.com',
          uid: 'user123',
          deviceToken: 'token123',
          contactNo: '+1234567890',
          role: 'Employee',
        ),
        attachment: {
          'fileId': 'appwrite_file_id_456',
          'fileName': 'medical_certificate.pdf',
          'fileSize': 512000,
          'uploadedAt': DateTime.now().toIso8601String(),
          'appwriteBucketId': 'attachments',
        },
        submittedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Submit the leave application
      final leaveId = await leavesService.createLeaveApplication(leave);

      print('Manual leave application created with ID: $leaveId');
    } catch (e) {
      print('Error creating manual leave application: $e');
    }
  }

  /// Example of how to handle Appwrite file attachments
  static void appwriteFileHandlingExample() {
    print('=== Appwrite File Attachment Example ===');

    // Simulate a leave with Appwrite attachment
    final leave = LeaveModel(
      leaveType: 'Sick Leave',
      startDate: '2024-01-20',
      endDate: '2024-01-21',
      reason: 'Medical appointment',
      description: 'Need to visit doctor',
      status: LeaveStatus.pending,
      user: UserModel(
        name: 'Jane Doe',
        email: 'jane.doe@example.com',
        uid: 'user456',
        deviceToken: 'token456',
        contactNo: '+1234567890',
        role: 'Employee',
      ),
      attachment: {
        'fileId': 'appwrite_file_id_789',
        'fileName': 'doctor_note.pdf',
        'fileSize': 256000,
        'uploadedAt': DateTime.now().toIso8601String(),
        'appwriteBucketId': 'attachments',
      },
      submittedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Check if it's an Appwrite attachment
    if (leave.isAppwriteAttachment) {
      print('✅ This leave has an Appwrite file attachment');
      print('📁 File ID: ${leave.appwriteFileId}');
      print('📦 Bucket ID: ${leave.appwriteBucketId}');
      print('🔗 Download URL: ${leave.appwriteDownloadUrl}');
      print('📄 File Name: ${leave.attachment?['fileName']}');
      print(
        '📏 File Size: ${_formatFileSize(leave.attachment?['fileSize'] ?? 0)}',
      );
    } else {
      print('❌ This leave does not have an Appwrite attachment');
    }

    print('=====================================');
  }

  /// Helper method to format file size
  static String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// Usage instructions:
/// 
/// 1. Submit a leave application:
///    await LeavesServiceUsageExample.submitLeaveExample();
/// 
/// 2. Get user's leave applications:
///    await LeavesServiceUsageExample.getUserLeavesExample('user123');
/// 
/// 3. Approve a leave application:
///    await LeavesServiceUsageExample.approveLeaveExample('leave123', 'Manager Name');
/// 
/// 4. Reject a leave application:
///    await LeavesServiceUsageExample.rejectLeaveExample('leave123', 'Insufficient notice');
/// 
/// 5. Get leave statistics:
///    await LeavesServiceUsageExample.getLeaveStatsExample('user123');
/// 
/// 6. Use repository pattern:
///    await LeavesServiceUsageExample.repositoryPatternExample();
/// 
/// 7. Stream leave applications:
///    LeavesServiceUsageExample.streamLeavesExample('user123');
/// 
/// 8. Create leave manually:
///    await LeavesServiceUsageExample.createLeaveManuallyExample();
/// 
/// 9. Handle Appwrite file attachments:
///    LeavesServiceUsageExample.appwriteFileHandlingExample();
