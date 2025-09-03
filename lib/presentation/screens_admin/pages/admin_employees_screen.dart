// import 'package:arch_approve/core/constants/app_theme.dart';
// import 'package:arch_approve/presentation/screens_admin/controllers/admin_employees_controller.dart';
// import 'package:arch_approve/presentation/screens_admin/pages/components/add_employee_bottomsheet.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AdminEmployeesScreen extends StatelessWidget {
//   const AdminEmployeesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final c = Get.put(AdminEmployeesController());
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Mobile layout
//         return Scaffold(
//           body: Obx(() {
//             return ListView.separated(
//               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
//               itemBuilder: (context, index) {
//                 final u = c.employees[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: kPrimaryColor,
//                     child: Icon(Icons.person, color: kWhiteColor),
//                   ),
//                   title: Text(u.name),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('• ${u.email}', overflow: TextOverflow.ellipsis),
//                       Text('• ${u.contactNo}', overflow: TextOverflow.ellipsis),
//                     ],
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.shade50,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           u.role,
//                           style: const TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.redAccent),
//                         tooltip: "Delete Employee",
//                         onPressed: () async {
//                           final confirm = await showDialog<bool>(
//                             context: context,
//                             builder: (ctx) => AlertDialog(
//                               title: const Text("Delete Employee"),
//                               content: Text(
//                                 "Are you sure you want to delete ${u.name}?",
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(ctx, false),
//                                   child: const Text("Cancel"),
//                                 ),
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.redAccent,
//                                   ),
//                                   onPressed: () => Navigator.pop(ctx, true),
//                                   child: const Text("Delete"),
//                                 ),
//                               ],
//                             ),
//                           );

//                           if (confirm == true) {
//                             await c.deleteEmployee(u.uid);
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               separatorBuilder: (_, __) => const Divider(height: 1),
//               itemCount: c.employees.length,
//             );
//           }),
//           floatingActionButton: Container(
//             decoration: BoxDecoration(
//               gradient: kLightPrimaryGradient,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.25)),
//               ],
//             ),
//             child: FloatingActionButton.extended(
//               onPressed: () => openAddEmployeeBottomSheet(context, c),
//               backgroundColor: Colors.transparent, // important!
//               elevation: 0, // so shadow matches container

//               label: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.person_add, color: kWhiteColor),
//                   SizedBox(width: 5),
//                   Text(
//                     "Add Employee",
//                     style: TextStyle(
//                       color: kWhiteColor,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/presentation/screens_admin/controllers/admin_employees_controller.dart';
import 'package:arch_approve/presentation/screens_admin/pages/components/add_employee_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminEmployeesScreen extends StatelessWidget {
  const AdminEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AdminEmployeesController());
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile layout
        return Scaffold(
          appBar: AppBar(
            title: const Text('Employee Dashboard'),
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
          ),
          body: Obx(() {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              itemBuilder: (context, index) {
                final u = c.employees[index];

                return Dismissible(
                  key: ValueKey(u.uid),
                  direction: DismissDirection.endToStart, // swipe left
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Delete Employee"),
                        content: Text(
                          "Are you sure you want to delete ${u.name}?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (direction) async {
                    await c.deleteEmployee(u.uid);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: const Icon(Icons.person, color: kWhiteColor),
                    ),
                    title: Text(u.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ${u.email}', overflow: TextOverflow.ellipsis),
                        Text(
                          '• ${u.contactNo}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        u.role,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemCount: c.employees.length,
            );
          }),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              gradient: kLightPrimaryGradient,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.25)),
              ],
            ),
            child: FloatingActionButton.extended(
              onPressed: () => openAddEmployeeBottomSheet(context, c),
              backgroundColor: Colors.transparent, // important!
              elevation: 0,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person_add, color: kWhiteColor),
                  const SizedBox(width: 5),
                  const Text(
                    "Add Employee",
                    style: TextStyle(
                      color: kWhiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
