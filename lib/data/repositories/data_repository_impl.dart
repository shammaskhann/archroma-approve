import 'package:arch_approve/core/services/firebase/data_service.dart';
import 'package:arch_approve/data/models/User_Model.dart';
import 'package:arch_approve/domain/repositories/firebase_data_repositroy.dart';

class FirebaseDataRepositoryImpl implements FirebaseDataRepository {
  final FirebaseDataService _firebaseDataService;

  FirebaseDataRepositoryImpl(this._firebaseDataService);

  @override
  Future<UserModel?> getUserData(String uid) {
    return _firebaseDataService.getUserData(uid);
  }

  @override
  Future<void> updateUserData(String uid, Map<String, dynamic> data) {
    return _firebaseDataService.updateUserData(uid, data);
  }

  @override
  Future<void> updateDeviceToken(String uid, String deviceToken) {
    return _firebaseDataService.updateDeviceToken(uid, deviceToken);
  }
}
