import 'package:arch_approve/core/services/firebase/leave_services.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LeavesHistoryController extends GetxController {
  final FirebaseLeavesService _firebaseLeavesService = FirebaseLeavesService();
  RxList<LeaveModel> pendingLeaves = <LeaveModel>[].obs;
  RxList<LeaveModel> acceptedLeaves = <LeaveModel>[].obs;
  RxList<LeaveModel> rejectedLeaves = <LeaveModel>[].obs;
  final _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLeaves();
  }

  _loadLeaves() async {
    final uid = _auth.currentUser?.uid;
    try {
      final userLeave = await _firebaseLeavesService.getUserLeaves(uid!);
      pendingLeaves.assignAll(
        userLeave
            .where((leave) => leave.status == LeaveStatus.pending)
            .toList(),
      );
      acceptedLeaves.assignAll(
        userLeave
            .where((leave) => leave.status == LeaveStatus.accepted)
            .toList(),
      );
      rejectedLeaves.assignAll(
        userLeave
            .where((leave) => leave.status == LeaveStatus.rejected)
            .toList(),
      );
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}
