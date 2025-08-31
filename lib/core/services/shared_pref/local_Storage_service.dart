import 'package:arch_approve/data/models/User_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static const String _nameKey = 'name';
  static const String _emailKey = 'email';
  static const String _uidKey = 'uid';
  static const String _deviceTokenKey = 'deviceToken';
  static const String _contactNoKey = 'contactNo';
  static const String _roleKey = 'role';

  static Future<void> saveData(UserModel admin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, admin.name);
    await prefs.setString(_emailKey, admin.email);
    await prefs.setString(_uidKey, admin.uid);
    await prefs.setString(_deviceTokenKey, admin.deviceToken);
    await prefs.setString(_contactNoKey, admin.contactNo);
    await prefs.setString(_roleKey, admin.role);
  }

  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_uidKey);
    await prefs.remove(_deviceTokenKey);
    await prefs.remove(_contactNoKey);
    await prefs.remove(_roleKey);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_uidKey);
  }

  static Future<String?> getDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deviceTokenKey);
  }

  static Future<String?> getContactNo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_contactNoKey);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }
}
