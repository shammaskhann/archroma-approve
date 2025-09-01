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

  /// Create a new leave application
  Future<String> createLeaveApplication(LeaveModel leave) async {
    try {
      final docRef = await _firestore.collection(_collectionName).add({
        ...leave.toFirestore(),
        'submittedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
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
    String leaveId,
    LeaveStatus status, {
    String? approvedBy,
    String? rejectionReason,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'status': status.name,
        'updatedAt': FieldValue.serverTimestamp(),
      };

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
          .doc(leaveId)
          .update(updateData);
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
}
