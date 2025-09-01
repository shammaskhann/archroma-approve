import 'package:arch_approve/core/services/firebase/leave_services.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:arch_approve/domain/repositories/firebase_leaves_repository.dart';

class FirebaseLeavesRepositoryImpl implements FirebaseLeavesRepository {
  final FirebaseLeavesService _firebaseLeavesService;

  FirebaseLeavesRepositoryImpl(this._firebaseLeavesService);

  @override
  Future<String> createLeaveApplication(LeaveModel leave) {
    return _firebaseLeavesService.createLeaveApplication(leave);
  }

  @override
  Future<LeaveModel?> getLeaveById(String leaveId) {
    return _firebaseLeavesService.getLeaveById(leaveId);
  }

  @override
  Future<List<LeaveModel>> getUserLeaves(String uid) {
    return _firebaseLeavesService.getUserLeaves(uid);
  }

  @override
  Future<List<LeaveModel>> getAllLeaves() {
    return _firebaseLeavesService.getAllLeaves();
  }

  @override
  Future<List<LeaveModel>> getPendingLeaves() {
    return _firebaseLeavesService.getPendingLeaves();
  }

  @override
  Future<void> updateLeaveStatus(
    String leaveId,
    LeaveStatus status, {
    String? approvedBy,
    String? rejectionReason,
  }) {
    return _firebaseLeavesService.updateLeaveStatus(
      leaveId,
      status,
      approvedBy: approvedBy,
      rejectionReason: rejectionReason,
    );
  }

  @override
  Future<void> updateLeaveApplication(
    String leaveId,
    Map<String, dynamic> data,
  ) {
    return _firebaseLeavesService.updateLeaveApplication(leaveId, data);
  }

  @override
  Future<void> deleteLeaveApplication(String leaveId) {
    return _firebaseLeavesService.deleteLeaveApplication(leaveId);
  }

  @override
  Future<Map<String, int>> getUserLeaveStats(String uid) {
    return _firebaseLeavesService.getUserLeaveStats(uid);
  }

  @override
  Future<String> createLeaveApplicationWithUser({
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reason,
    required String description,
    Map<String, dynamic>? attachment,
  }) {
    return _firebaseLeavesService.createLeaveApplicationWithUser(
      leaveType: leaveType,
      startDate: startDate,
      endDate: endDate,
      reason: reason,
      description: description,
      attachment: attachment,
    );
  }

  @override
  Stream<List<LeaveModel>> streamUserLeaves(String uid) {
    return _firebaseLeavesService.streamUserLeaves(uid);
  }

  @override
  Stream<List<LeaveModel>> streamAllLeaves() {
    return _firebaseLeavesService.streamAllLeaves();
  }

  @override
  Stream<List<LeaveModel>> streamPendingLeaves() {
    return _firebaseLeavesService.streamPendingLeaves();
  }
}
