import 'package:arch_approve/data/models/User_Model.dart';
import 'package:arch_approve/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseEmployeeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create an employee using a secondary Firebase app so the admin session stays intact
  Future<UserModel> createEmployee({
    required String name,
    required String email,
    required String password,
    required String contactNo,
    String role = 'employee',
  }) async {
    FirebaseApp? secondaryApp;
    try {
      // Initialize secondary app
      secondaryApp = await Firebase.initializeApp(
        name: 'secondary',
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);
      final credential = await secondaryAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final userModel = UserModel(
        name: name,
        email: email,
        uid: uid,
        deviceToken: '',
        contactNo: contactNo,
        role: role,
      );

      await _firestore.collection('employee').doc(uid).set(userModel.toJson());

      // Ensure secondary user is signed out and app is deleted
      await secondaryAuth.signOut();

      return userModel;
    } finally {
      if (secondaryApp != null) {
        await secondaryApp.delete();
      }
    }
  }

  Future<void> deleteEmployee({required String uid}) async {
    try {
      await _firestore.collection("employee").doc(uid).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<UserModel>> streamEmployees() {
    return _firestore
        .collection('employee')
        .orderBy('name')
        .snapshots()
        .map(
          (s) => s.docs
              .map(
                (d) => UserModel.fromJson(
                  d.data()..putIfAbsent('uid', () => d.id),
                ),
              )
              .toList(),
        );
  }
}
