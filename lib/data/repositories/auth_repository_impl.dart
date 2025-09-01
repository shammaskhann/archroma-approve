// data/repositories/auth_repository_impl.dart
import 'package:arch_approve/core/services/firebase/auth_services.dart';
import 'package:arch_approve/core/services/firebase/data_service.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:arch_approve/data/models/User_Model.dart';
import 'package:arch_approve/domain/repositories/firebase_data_repositroy.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService;
  final FirebaseDataService _firebaseDataRepository;

  AuthRepository(this._firebaseAuthService, this._firebaseDataRepository);

  Future<UserModel?> signIn(String email, String password) async {
    try {
      final user = await _firebaseAuthService.signInWithEmail(
        email: email,
        password: password,
      );
      final UserModel? userModel = await _firebaseDataRepository.getUserData(
        user!.uid,
      );
      await UserPref.saveData(userModel!);
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AuthFailure.fromCode(e.code);
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuthService.sendPasswordResetEmail(email);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure.fromCode(e.code);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }

  User? get currentUser => _firebaseAuthService.currentUser;
}

/// Example of domain-friendly error handling
class AuthFailure implements Exception {
  final String message;

  AuthFailure(this.message);

  factory AuthFailure.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return AuthFailure('No user found with this email.');
      case 'wrong-password':
        return AuthFailure('Incorrect password.');
      case 'invalid-email':
        return AuthFailure('The email address is not valid.');
      default:
        return AuthFailure('Authentication failed. Please try again.');
    }
  }
}
