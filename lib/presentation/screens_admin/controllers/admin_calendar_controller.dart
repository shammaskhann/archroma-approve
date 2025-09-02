import 'package:arch_approve/core/services/firebase/leave_services.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:get/get.dart';

class AdminCalendarController extends GetxController {
  final FirebaseLeavesService _leaves = FirebaseLeavesService();

  final Rx<DateTime> focusedMonth = DateTime.now().obs;
  final RxList<LeaveModel> all = <LeaveModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _leaves.streamAllLeaves().listen((events) => all.assignAll(events));
  }

  List<LeaveModel> leavesForDay(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    return all.where((e) {
      final start = DateTime.parse(e.startDate);
      final end = DateTime.parse(e.endDate);
      final startD = DateTime(start.year, start.month, start.day);
      final endD = DateTime(end.year, end.month, end.day);
      return (d.isAtSameMomentAs(startD) || d.isAfter(startD)) &&
          (d.isAtSameMomentAs(endD) || d.isBefore(endD));
    }).toList();
  }
}
