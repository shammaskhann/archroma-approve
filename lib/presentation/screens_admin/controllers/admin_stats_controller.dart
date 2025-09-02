import 'package:arch_approve/core/services/firebase/leave_services.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:get/get.dart';

class AdminStatsController extends GetxController {
  final FirebaseLeavesService _leaves = FirebaseLeavesService();

  final RxInt total = 0.obs;
  final RxInt pending = 0.obs;
  final RxInt accepted = 0.obs;
  final RxInt rejected = 0.obs;

  final RxMap<String, int> monthTotals =
      <String, int>{}.obs; // yyyy-MM -> count

  @override
  void onInit() {
    super.onInit();
    _leaves.streamAllLeaves().listen((events) => _compute(events));
  }

  void _compute(List<LeaveModel> list) {
    total.value = list.length;
    pending.value = list.where((e) => e.status == LeaveStatus.pending).length;
    accepted.value = list.where((e) => e.status == LeaveStatus.accepted).length;
    rejected.value = list.where((e) => e.status == LeaveStatus.rejected).length;

    final map = <String, int>{};
    for (final e in list) {
      final key =
          '${e.submittedAt.year.toString().padLeft(4, '0')}-${e.submittedAt.month.toString().padLeft(2, '0')}';
      map.update(key, (v) => v + 1, ifAbsent: () => 1);
    }
    monthTotals.assignAll(map);
  }
}
