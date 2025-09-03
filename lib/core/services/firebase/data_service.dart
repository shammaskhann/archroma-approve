import 'package:arch_approve/data/models/User_Model.dart';
import 'package:arch_approve/data/models/leaveStats_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDataService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get User Data by UID
  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection("employee").doc(uid).get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!..putIfAbsent('uid', () => uid));
      }
      return null;
    } catch (e) {
      print("Error getting user data: $e");
      return null;
    }
  }

  Future<List<String>> getAdminDeviceTokens() async {
    try {
      final querySnapshot = await _firestore
          .collection("employee")
          .where("role", isEqualTo: "admin")
          .get();

      // Map each document to UserModel and extract deviceToken
      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['uid'] = doc.id; // attach UID
            return UserModel.fromJson(data).deviceToken;
          })
          .where((token) => token.isNotEmpty) // only keep non-empty tokens
          .toList();
    } catch (e) {
      print("Error getting admin device tokens: $e");
      return [];
    }
  }

  /// Update user data (merge with existing)
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection("employee")
          .doc(uid)
          .set(data, SetOptions(merge: true));
    } catch (e) {
      print("Error updating user data: $e");
      rethrow;
    }
  }

  /// Update only the deviceToken
  Future<void> updateDeviceToken(String uid, String deviceToken) async {
    try {
      await _firestore.collection("employee").doc(uid).update({
        'deviceToken': deviceToken,
      });
    } catch (e) {
      print("Error updating device token: $e");
      rethrow;
    }
  }

  /// Get current logged-in Firebase User
  User? get currentUser => _auth.currentUser;
}
