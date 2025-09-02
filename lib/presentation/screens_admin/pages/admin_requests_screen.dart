import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:arch_approve/presentation/screens_admin/controllers/admin_requests_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRequestsScreen extends StatelessWidget {
  const AdminRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AdminRequestsController());
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile layout
        return Scaffold(
          body: Obx(() {
            final items = c.filteredRequests;
            if (items.isEmpty) {
              return const Center(child: Text('No requests'));
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(child: _MonthFilter(c: c)),
                      const SizedBox(width: 12),
                      Expanded(child: _StatusFilter(c: c)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (_, i) => _RequestTile(item: items[i], c: c),
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemCount: items.length,
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

class _MonthFilter extends StatelessWidget {
  final AdminRequestsController c;
  const _MonthFilter({required this.c});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: c.monthFilter.value.isEmpty ? null : c.monthFilter.value,
      items: [
        const DropdownMenuItem(value: '', child: Text('All months')),
        ...List.generate(12, (i) {
          final now = DateTime.now();
          final m = DateTime(now.year, i + 1, 1);
          final v =
              '${m.year.toString().padLeft(4, '0')}-${m.month.toString().padLeft(2, '0')}';
          return DropdownMenuItem(value: v, child: Text(v));
        }),
      ],
      onChanged: (v) => c.monthFilter.value = v ?? '',
      decoration: const InputDecoration(labelText: 'Month'),
    );
  }
}

class _StatusFilter extends StatelessWidget {
  final AdminRequestsController c;
  const _StatusFilter({required this.c});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: c.statusFilter.value,
      items: const [
        DropdownMenuItem(value: 'all', child: Text('All')),
        DropdownMenuItem(value: 'pending', child: Text('Pending')),
        DropdownMenuItem(value: 'accepted', child: Text('Approved')),
        DropdownMenuItem(value: 'rejected', child: Text('Rejected')),
      ],
      onChanged: (v) => c.statusFilter.value = v ?? 'all',
      decoration: const InputDecoration(labelText: 'Status'),
    );
  }
}

class _RequestTile extends StatelessWidget {
  final LeaveModel item;
  final AdminRequestsController c;
  const _RequestTile({required this.item, required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.isApproved
              ? Colors.green
              : item.isRejected
              ? Colors.red
              : Colors.orange,
          child: const Icon(Icons.event, color: Colors.white),
        ),
        title: Text('${item.user.name} • ${item.leaveType}'),
        subtitle: Text('${item.startDate} → ${item.endDate}\n${item.reason}'),
        isThreeLine: true,
        trailing: _Actions(item: item, c: c),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  final LeaveModel item;
  final AdminRequestsController c;
  const _Actions({required this.item, required this.c});

  @override
  Widget build(BuildContext context) {
    if (!item.isPending) {
      return Text(
        item.statusDisplayText,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
    }
    return Wrap(
      spacing: 8,
      children: [
        OutlinedButton(
          onPressed: () async {
            await c.approve(item.id!, approvedBy: 'admin');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Approved')));
          },
          child: const Text('Approve'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: kPrimaryColor),
          onPressed: () async {
            final reason = await _askReason(context);
            if (reason != null && reason.isNotEmpty) {
              await c.reject(item.id!, reason: reason);
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Rejected')));
              }
            }
          },
          child: const Text('Reject'),
        ),
      ],
    );
  }

  Future<String?> _askReason(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Rejection reason'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Reason'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
