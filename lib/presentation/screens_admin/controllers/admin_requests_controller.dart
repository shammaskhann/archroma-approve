import 'package:arch_approve/core/services/firebase/leave_services.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:get/get.dart';

class AdminRequestsController extends GetxController {
  final FirebaseLeavesService _leaves = FirebaseLeavesService();

  final RxList<LeaveModel> allRequests = <LeaveModel>[].obs;
  final RxList<LeaveModel> pendingRequestList = <LeaveModel>[].obs;
  final RxString monthFilter = ''.obs; // e.g. '2025-09'
  final RxString statusFilter = 'all'.obs; // all|pending|accepted|rejected

  @override
  void onInit() {
    super.onInit();
    _leaves.streamPendingLeaves().listen((events) {
      pendingRequestList.assignAll(events);
    });
    _leaves.streamAllLeaves().listen((event) {
      allRequests.assignAll(event);
    });
  }

  List<LeaveModel> get pendingRequests {
    return pendingRequestList.toList();
  }

  Future<void> approve(LeaveModel model) async {
    await _leaves.updateLeaveStatus(
      model,
      LeaveStatus.accepted,
      // approvedBy: approvedBy,
    );
  }

  Future<void> reject(LeaveModel model, {required String reason}) async {
    await _leaves.updateLeaveStatus(
      model,
      LeaveStatus.rejected,
      rejectionReason: reason,
    );
  }
}
