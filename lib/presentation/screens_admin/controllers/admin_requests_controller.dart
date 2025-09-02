import 'package:arch_approve/core/services/firebase/leave_services.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:get/get.dart';

class AdminRequestsController extends GetxController {
  final FirebaseLeavesService _leaves = FirebaseLeavesService();

  final RxList<LeaveModel> allRequests = <LeaveModel>[].obs;
  final RxString monthFilter = ''.obs; // e.g. '2025-09'
  final RxString statusFilter = 'all'.obs; // all|pending|accepted|rejected

  @override
  void onInit() {
    super.onInit();
    _leaves.streamAllLeaves().listen((events) {
      allRequests.assignAll(events);
    });
  }

  List<LeaveModel> get filteredRequests {
    return allRequests.where((r) {
      final matchesStatus =
          statusFilter.value == 'all' || r.status.name == statusFilter.value;
      final matchesMonth =
          monthFilter.value.isEmpty ||
          _formatMonth(r.submittedAt) == monthFilter.value;
      return matchesStatus && matchesMonth;
    }).toList();
  }

  String _formatMonth(DateTime dt) =>
      '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}';

  Future<void> approve(String id, {required String approvedBy}) async {
    await _leaves.updateLeaveStatus(
      id,
      LeaveStatus.accepted,
      approvedBy: approvedBy,
    );
  }

  Future<void> reject(String id, {required String reason}) async {
    await _leaves.updateLeaveStatus(
      id,
      LeaveStatus.rejected,
      rejectionReason: reason,
    );
  }
}
