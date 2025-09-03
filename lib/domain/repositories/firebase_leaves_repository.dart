import 'package:arch_approve/data/models/Leave_Model.dart';

abstract class FirebaseLeavesRepository {
  /// Create a new leave application
  Future<String> createLeaveApplication(LeaveModel leave);

  /// Get leave application by ID
  Future<LeaveModel?> getLeaveById(String leaveId);

  /// Get all leave applications for a specific user
  Future<List<LeaveModel>> getUserLeaves(String uid);

  /// Get all leave applications (for managers/admins)
  Future<List<LeaveModel>> getAllLeaves();

  /// Get pending leave applications
  Future<List<LeaveModel>> getPendingLeaves();

  /// Update leave status (approve/reject)
  Future<void> updateLeaveStatus(
    LeaveModel leave,
    LeaveStatus status, {
    String? approvedBy,
    String? rejectionReason,
  });

  /// Update leave application details
  Future<void> updateLeaveApplication(
    String leaveId,
    Map<String, dynamic> data,
  );

  /// Delete leave application
  Future<void> deleteLeaveApplication(String leaveId);

  /// Get leave statistics for a user
  Future<Map<String, int>> getUserLeaveStats(String uid);

  /// Create leave application with current user data
  Future<String> createLeaveApplicationWithUser({
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reason,
    required String description,
    Map<String, dynamic>? attachment,
    required String leaveDuration,
    required bool shouldDeduct,
    required String deductForm,
  });

  /// Stream of user's leave applications
  Stream<List<LeaveModel>> streamUserLeaves(String uid);

  /// Stream of all leave applications (for managers/admins)
  Stream<List<LeaveModel>> streamAllLeaves();

  /// Stream of pending leave applications
  Stream<List<LeaveModel>> streamPendingLeaves();
}
