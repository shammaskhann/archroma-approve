import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:get/get.dart';
import 'package:arch_approve/core/services/firebase/leave_services.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  final FirebaseLeavesService _leavesService = FirebaseLeavesService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observable variables
  final Rxn<LeaveModel> recentLeave = Rxn<LeaveModel>();
  final RxList<LeaveModel> allLeaves = <LeaveModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRecentLeave();
  }

  /// Load the most recent leave application
  Future<void> _loadRecentLeave() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        errorMessage.value = 'User not authenticated';
        return;
      }

      // Get user's leaves and find the most recent one
      final userLeaves = await _leavesService.getUserLeaves(currentUser.uid);

      if (userLeaves.isNotEmpty) {
        // Sort by submitted date and get the most recent
        userLeaves.sort((a, b) => b.submittedAt.compareTo(a.submittedAt));
        recentLeave.value = userLeaves.first;
        allLeaves.assignAll(userLeaves);
      }
    } catch (e) {
      errorMessage.value = 'Error loading recent leave: $e';
      print('Error loading recent leave: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh the data
  Future<void> refreshData() async {
    await _loadRecentLeave();
  }

  /// Get leave statistics
  Map<String, int> getLeaveStats() {
    final leaves = allLeaves;
    int pending = 0;
    int accepted = 0;
    int rejected = 0;

    for (final leave in leaves) {
      switch (leave.status) {
        case LeaveStatus.pending:
          pending++;
          break;
        case LeaveStatus.accepted:
          accepted++;
          break;
        case LeaveStatus.rejected:
          rejected++;
          break;
      }
    }

    return {
      'pending': pending,
      'accepted': accepted,
      'rejected': rejected,
      'total': leaves.length,
    };
  }

  /// Check if user has any leaves
  bool get hasLeaves => allLeaves.isNotEmpty;

  /// Get the most recent leave
  LeaveModel? get getRecentLeave => recentLeave.value;

  /// Get loading state
  bool get getIsLoading => isLoading.value;

  /// Get error message
  String get getErrorMessage => errorMessage.value;

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  /// Navigate to view all leaves
  void viewAllLeaves() {
    Get.toNamed(AppRoutesConstant.history);
  }

  /// Navigate to leave details
  void viewLeaveDetails(LeaveModel leave) {
    // You can implement navigation to leave details screen
    Get.snackbar(
      'Leave Details',
      'Viewing details for ${leave.leaveType}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Get formatted date for display
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  /// Get status color for leave
  Map<String, dynamic> getStatusInfo(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.pending:
        return {
          'color': 0xFFFF9800, // Orange
          'text': 'Pending',
          'icon': '⏳',
        };
      case LeaveStatus.accepted:
        return {
          'color': 0xFF4CAF50, // Green
          'text': 'Approved',
          'icon': '✅',
        };
      case LeaveStatus.rejected:
        return {
          'color': 0xFFF44336, // Red
          'text': 'Rejected',
          'icon': '❌',
        };
    }
  }
}
