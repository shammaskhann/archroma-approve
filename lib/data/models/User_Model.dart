import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const String _nameKey = 'name';
  static const String _emailKey = 'email';
  static const String _uidKey = 'uid';
  static const String _deviceTokenKey = 'deviceToken';
  static const String _contactNoKey = 'contactNo';
  static const String _roleKey = 'role';
  static const String _casualLeavesKey = 'casual_leaves';
  static const String _annualLeavesKey = 'annual_leaves';
  static const String _sickLeavesKey = 'sick_leaves';

  final String name;
  final String email;
  final String uid;
  final String deviceToken;
  final String contactNo;
  final String role;
  final int casualLeaves;
  final int annualLeaves;
  final int sickLeaves;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.deviceToken,
    required this.contactNo,
    required this.role,
    required this.casualLeaves,
    required this.annualLeaves,
    required this.sickLeaves,
  });

  /// From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json[_nameKey] ?? "",
      email: json[_emailKey] ?? "",
      uid: json[_uidKey] ?? "",
      deviceToken: json[_deviceTokenKey] ?? "",
      contactNo: json[_contactNoKey] ?? "",
      role: json[_roleKey] ?? "",
      casualLeaves: json[_casualLeavesKey] ?? 0,
      annualLeaves: json[_annualLeavesKey] ?? 0,
      sickLeaves: json[_sickLeavesKey] ?? 0,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      _nameKey: name,
      _emailKey: email,
      _uidKey: uid,
      _deviceTokenKey: deviceToken,
      _contactNoKey: contactNo,
      _roleKey: role,
      _casualLeavesKey: casualLeaves,
      _annualLeavesKey: annualLeaves,
      _sickLeavesKey: sickLeaves,
    };
  }

  /// From Firestore DocumentSnapshot
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return UserModel(
      name: data?[_nameKey] ?? "",
      email: data?[_emailKey] ?? "",
      uid: data?[_uidKey] ?? "",
      deviceToken: data?[_deviceTokenKey] ?? "",
      contactNo: data?[_contactNoKey] ?? "",
      role: data?[_roleKey] ?? "",
      casualLeaves: data?[_casualLeavesKey] ?? 0,
      annualLeaves: data?[_annualLeavesKey] ?? 0,
      sickLeaves: data?[_sickLeavesKey] ?? 0,
    );
  }

  /// To Firestore (same as JSON)
  Map<String, dynamic> toFirestore() => toJson();
}
