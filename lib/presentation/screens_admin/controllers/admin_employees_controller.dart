import 'package:arch_approve/core/services/firebase/employee_service.dart';
import 'package:arch_approve/data/models/User_Model.dart';
import 'package:get/get.dart';

class AdminEmployeesController extends GetxController {
  final FirebaseEmployeeService _service = FirebaseEmployeeService();

  final RxList<UserModel> employees = <UserModel>[].obs;
  final RxBool isCreating = false.obs;
  final RxString errorMessage = ''.obs;

  late final Stream<List<UserModel>> _stream;

  @override
  void onInit() {
    super.onInit();
    _stream = _service.streamEmployees();
    ever<List<UserModel>>(employees, (_) {});
    _stream.listen(
      (list) => employees.assignAll(list),
      onError: (e) {
        errorMessage.value = e.toString();
      },
    );
  }

  Future<void> addEmployee({
    required String name,
    required String email,
    required String password,
    required String contactNo,
    String role = 'employee',
  }) async {
    isCreating.value = true;
    errorMessage.value = '';
    try {
      await _service.createEmployee(
        name: name,
        email: email,
        password: password,
        contactNo: contactNo,
        role: role,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isCreating.value = false;
    }
  }

  Future<void> deleteEmployee(String uid) async {
    try {
      await _service.deleteEmployee(uid: uid);
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    }
  }
}
