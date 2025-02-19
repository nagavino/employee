// employee_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../domain/constants.dart';
import '../../../domain/riverpod/provider/provider.dart';
import '../../../infrastructure/models/employee/employee_model.dart';

import '../../components/loading_effects/nodata_found.dart';

import 'employee_details.dart';

class EmployeeList extends ConsumerWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeState = ref.watch(employeeListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: employeeState.when(
        data: (employees) {
          if (employees.isEmpty) {
            return const NoDataIllustration();
          }

          // Separate employees into current and previous
          final now = DateTime.now();
          final currentEmployees = employees
              .where((e) => e.endDate == null || e.endDate!.isAfter(now))
              .toList();
          final previousEmployees = employees
              .where((e) => e.endDate != null && e.endDate!.isBefore(now))
              .toList();

          // Sort employees by start date (descending)
          currentEmployees.sort((a, b) => b.startDate.compareTo(a.startDate));
          previousEmployees.sort((a, b) => b.startDate.compareTo(a.startDate));

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(employeeListProvider.notifier).fetchEmployees(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentEmployees.isNotEmpty) ...[
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: Constants.sideHorizontalSpace,
                            right: Constants.sideHorizontalSpace,
                            top: Constants.sideVerticalSpace,
                            bottom: Constants.sideVerticalSpace),
                        child: Text('Current employees',
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ),
                    ...currentEmployees
                        .map((emp) => EmployeeListTile(employee: emp)),
                  ],
                  if (previousEmployees.isNotEmpty) ...[
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: Constants.sideHorizontalSpace,
                            right: Constants.sideHorizontalSpace,
                            top: Constants.sideVerticalSpace,
                            bottom: Constants.sideVerticalSpace),
                        child: Text('Previous employees',
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ),
                    ...previousEmployees
                        .map((emp) => EmployeeListTile(employee: emp)),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Constants.sideHorizontalSpace,
                        top: Constants.sideVerticalSpace,
                        bottom: 20),
                    child: Text(
                      'Swipe Left to delete',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                Constants.btnBorderRadius), // Adjust the radius as needed
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EmployeeDetails()),
            );
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class EmployeeListTile extends ConsumerWidget {
  final Employee employee;
  const EmployeeListTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = DateFormat('d MMM yyyy').format(employee.startDate);
    final endDate = employee.endDate != null
        ? DateFormat('d MMM yyyy').format(employee.endDate!)
        : 'Present';

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Dismissible(
        key: ValueKey(employee.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          final shouldDelete = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirm Deletion'),
                content:
                    const Text('Do you really want to delete this record?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              );
            },
          );
          return shouldDelete ?? false;
        },
        onDismissed: (_) {
          // Store the deleted employee for Undo.
          final deletedEmployee = employee;

          // Perform deletion.
          ref.read(employeeListProvider.notifier).deleteEmployee(employee.id!);

          // Show a SnackBar with an Undo option.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Employee data has been deleted'),
              action: SnackBarAction(
                label: 'Undo',
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  ref
                      .read(employeeListProvider.notifier)
                      .addEmployee(deletedEmployee);
                },
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        },
        child: ListTile(
          title: Text(
            employee.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employee.role, style: Theme.of(context).textTheme.bodyLarge),
              Text('$startDate → $endDate',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          isThreeLine: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EmployeeDetails(employee: employee),
              ),
            );
          },
        ),
      ),
    );
  }
}
