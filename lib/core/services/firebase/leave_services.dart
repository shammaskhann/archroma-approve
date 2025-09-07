import 'dart:developer';

import 'package:arch_approve/core/services/notification/fcm_sender_service.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:arch_approve/data/models/leaveStats_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:arch_approve/data/models/User_Model.dart';
import 'package:arch_approve/core/services/firebase/data_service.dart';

class FirebaseLeavesService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseDataService _dataService = FirebaseDataService();

  static const String _collectionName = 'Leaves post';

  bool isSameDateString(String a, String b) {
    final dateA = DateTime.parse(a);
    //log(dateA.toString());

    final dateB = DateTime.parse(b);
    //log(dateB.toString());
    bool res =
        dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day;
    //log(res.toString());
    return res;
  }

  /// Create a new leave application
  Future<String> createLeaveApplication(LeaveModel leave) async {
    try {
      final docRef = await _firestore.collection(_collectionName).add({
        ...leave.toFirestore(),
        'submittedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      List<String> tokens = await _dataService.getAdminDeviceTokens();
      // ✅ Fire-and-forget notification sending
      Future.microtask(() {
        for (final token in tokens) {
          bool isSameDay = isSameDateString(leave.startDate, leave.endDate);
          String body;
          if (isSameDay) {
            body =
                "${leave.user.name} has submitted a ${leave.leaveType} leave request "
                "of ${leave.startDate}";
          } else {
            body =
                "${leave.user.name} has submitted a ${leave.leaveType} leave request "
                "from ${leave.startDate} to ${leave.endDate}.";
          }
          FcmSenderService.sendNotification(
            token,
            "New Leave Request", // ✅ clear, short, professional
            body, // ✅ descriptive & formal
            {
              "leaveId": docRef.id,
              "leaveType": leave.leaveType,
              "startDate": leave.startDate,
              "endDate": leave.endDate,
              "reason": leave.reason,
              "userId": leave.user.uid,
            },
          );
        }
      });

      return docRef.id;
    } catch (e) {
      print('Error creating leave application: $e');
      rethrow;
    }
  }

  /// Get leave application by ID
  Future<LeaveModel?> getLeaveById(String leaveId) async {
    try {
      final doc = await _firestore
          .collection(_collectionName)
          .doc(leaveId)
          .get();

      if (doc.exists && doc.data() != null) {
        return LeaveModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error getting leave by ID: $e');
      return null;
    }
  }

  /// Get all leave applications for a specific user
  Future<List<LeaveModel>> getUserLeaves(String uid) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('user.uid', isEqualTo: uid)
          .orderBy('submittedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => LeaveModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting user leaves: $e');
      return [];
    }
  }

  Future<LeaveStatsModel?> getUserRemainingLeaveStats(String uid) async {
    try {
      final doc = await _firestore.collection("employee").doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return LeaveStatsModel.fromJson(doc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user leaves: $e');
      return null;
    }
  }

  /// Get all leave applications (for managers/admins)
  Future<List<LeaveModel>> getAllLeaves() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('submittedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => LeaveModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting all leaves: $e');
      return [];
    }
  }

  /// Get pending leave applications
  Future<List<LeaveModel>> getPendingLeaves() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('status', isEqualTo: 'pending')
          .orderBy('submittedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => LeaveModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting pending leaves: $e');
      return [];
    }
  }

  /// Update leave status (approve/reject)
  Future<void> updateLeaveStatus(
    LeaveModel leave,
    LeaveStatus status, {
    // String? approvedBy,
    String? rejectionReason,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'status': status.name,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      String? approvedBy = await UserPref.getName();
      log("Updated Leave Status FCM Steps 0");
      await deductUserLeavesAccordingToRequest(leave);

      if (status == LeaveStatus.accepted) {
        updateData['approvedBy'] = approvedBy;
        updateData['approvedAt'] = FieldValue.serverTimestamp();
        updateData['rejectionReason'] = null;
      } else if (status == LeaveStatus.rejected) {
        updateData['rejectionReason'] = rejectionReason;
        updateData['approvedBy'] = null;
        updateData['approvedAt'] = null;
      }

      await _firestore
          .collection(_collectionName)
          .doc(leave.id)
          .update(updateData);
      log("Updated Leave Status FCM Steps");
      // Send notification in background (non-blocking)
      if (status == LeaveStatus.accepted) {
        final body =
            "Your ${leave.leaveType} leave from ${leave.startDate} to ${leave.endDate} has been approved.";
        Future.microtask(() {
          FcmSenderService.sendNotification(
            leave.user.deviceToken,
            "Leave Application Accepted",
            body,
            {},
          );
        });
      } else if (status == LeaveStatus.rejected) {
        final body =
            "Your ${leave.leaveType} leave from ${leave.startDate} to ${leave.endDate} was rejected."
            "${leave.rejectionReason != null ? " Reason: ${leave.rejectionReason}" : ""}";
        Future.microtask(() {
          FcmSenderService.sendNotification(
            leave.user.deviceToken,
            "Leave Application Rejected",
            body,
            {},
          );
        });
      }
    } catch (e) {
      print('Error updating leave status: $e');
      rethrow;
    }
  }

  /// Update leave application details
  Future<void> updateLeaveApplication(
    String leaveId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(_collectionName).doc(leaveId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating leave application: $e');
      rethrow;
    }
  }

  /// Delete leave application
  Future<void> deleteLeaveApplication(String leaveId) async {
    try {
      await _firestore.collection(_collectionName).doc(leaveId).delete();
    } catch (e) {
      print('Error deleting leave application: $e');
      rethrow;
    }
  }

  /// Get leave statistics for a user
  Future<Map<String, int>> getUserLeaveStats(String uid) async {
    try {
      final leaves = await getUserLeaves(uid);

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
    } catch (e) {
      print('Error getting user leave stats: $e');
      return {'pending': 0, 'accepted': 0, 'rejected': 0, 'total': 0};
    }
  }

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
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      // Get user data from FirebaseDataService
      final userData = await _dataService.getUserData(currentUser.uid);
      if (userData == null) {
        throw Exception('User data not found');
      }

      final leave = LeaveModel(
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
        description: description,
        status: LeaveStatus.pending,
        user: userData,
        attachment: attachment,
        submittedAt: DateTime.now(),
        updatedAt: DateTime.now(),
        leaveDuration: leaveDuration,
        shouldDeduct: shouldDeduct,
        deductForm: deductForm,
      );

      return await createLeaveApplication(leave);
    } catch (e) {
      print('Error creating leave application with user: $e');
      rethrow;
    }
  }

  /// Stream of user's leave applications
  Stream<List<LeaveModel>> streamUserLeaves(String uid) {
    return _firestore
        .collection(_collectionName)
        .where('user.uid', isEqualTo: uid)
        .orderBy('submittedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => LeaveModel.fromFirestore(doc))
              .toList(),
        );
  }

  /// Stream of all leave applications (for managers/admins)
  Stream<List<LeaveModel>> streamAllLeaves() {
    return _firestore
        .collection(_collectionName)
        .orderBy('submittedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => LeaveModel.fromFirestore(doc))
              .toList(),
        );
  }

  /// Stream of pending leave applications
  Stream<List<LeaveModel>> streamPendingLeaves() {
    return _firestore
        .collection(_collectionName)
        .where('status', isEqualTo: 'pending')
        .orderBy('submittedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => LeaveModel.fromFirestore(doc))
              .toList(),
        );
  }

  //Logic
  Future<void> deductUserLeavesAccordingToRequest(LeaveModel leave) async {
    // 🔥 Deduct from leave balance if not "special"
    if (leave.shouldDeduct && leave.deductForm.toLowerCase() != 'special') {
      final userId = leave.user.uid;
      final stats = await getUserRemainingLeaveStats(userId);

      int leaveDays = 0;
      if (leave.shouldDeduct) {
        DateTime start = DateTime.parse(leave.startDate);
        DateTime end = DateTime.parse(leave.endDate);
        leaveDays = end.difference(start).inDays + 1;
      } else {
        leaveDays = 0; // Half day — no deduction
      }

      if (stats != null) {
        int updatedCasual = stats.casualLeaves;
        int updatedAnnual = stats.annualLeaves;
        int updatedSick = stats.sickLeaves;

        switch (leave.deductForm.toLowerCase()) {
          case 'casual_leaves':
            updatedCasual = (updatedCasual - leaveDays).clamp(0, 999);
            break;
          case 'annual_leaves':
            updatedAnnual = (updatedAnnual - leaveDays).clamp(0, 999);
            break;
          case 'sick_leaves':
            updatedSick = (updatedSick - leaveDays).clamp(0, 999);
            break;
          default:
            print("Unknown deduction type: ${leave.deductForm}");
        }

        // 🔄 Update employee document
        await _firestore.collection("employee").doc(userId).update({
          'casual_leaves': updatedCasual,
          'annual_leaves': updatedAnnual,
          'sick_leaves': updatedSick,
        });
      }
    }
  }
}
