import 'package:arch_approve/data/models/User_Model.dart';

abstract class FirebaseDataRepository {
  Future<UserModel?> getUserData(String uid);
  Future<void> updateUserData(String uid, Map<String, dynamic> data);
  Future<void> updateDeviceToken(String uid, String deviceToken);
}
