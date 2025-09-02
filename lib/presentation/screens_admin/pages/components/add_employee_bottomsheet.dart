import 'dart:ui';
import 'package:arch_approve/presentation/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arch_approve/presentation/screens_admin/controllers/admin_employees_controller.dart';

void openAddEmployeeBottomSheet(
  BuildContext context,
  AdminEmployeesController c,
) async {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  String role = 'employee';

  await showModalBottomSheet(
    context: context,
    isDismissible: true, // allow closing when tapping outside
    enableDrag: true, // allow swipe down to close
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scrollController) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle bar
                      Center(
                        child: Container(
                          height: 4,
                          width: 40,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      Text(
                        "Add Employee",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      TextField(
                        controller: name,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextField(
                        controller: phone,
                        decoration: const InputDecoration(
                          labelText: 'Contact No',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        value: role,
                        items: const [
                          DropdownMenuItem(
                            value: 'employee',
                            child: Text('Employee'),
                          ),
                          DropdownMenuItem(
                            value: 'admin',
                            child: Text('Admin / IT'),
                          ),
                        ],
                        onChanged: (v) => role = v ?? 'employee',
                        decoration: const InputDecoration(
                          labelText: 'Role',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Obx(
                        () => AppButton(
                          showGradient: false,
                          text: "Submit",
                          isLoading: c.isCreating.value,
                          onPressed: () async {
                            await c.addEmployee(
                              name: name.text.trim(),
                              email: email.text.trim(),
                              password: password.text.trim(),
                              contactNo: phone.text.trim(),
                              role: role,
                            );
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
