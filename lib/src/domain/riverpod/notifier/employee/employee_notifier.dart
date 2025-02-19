import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../infrastructure/models/employee/employee_model.dart';

import '../../provider/provider.dart';

class EmployeeNotifier extends StateNotifier<AsyncValue<List<Employee>>> {
  final Ref ref;

  EmployeeNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      final employees =
          await ref.read(employeeRepositoryProvider).fetchAllEmployees();
      state = AsyncValue.data(employees);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      final newEmployee =
          await ref.read(employeeRepositoryProvider).addEmployee(employee);
      state.whenData((current) {
        state = AsyncValue.data([...current, newEmployee]);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      final updated =
          await ref.read(employeeRepositoryProvider).updateEmployee(employee);
      state.whenData((current) {
        final updatedList =
            current.map((emp) => emp.id == updated.id ? updated : emp).toList();
        state = AsyncValue.data(updatedList);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      await ref.read(employeeRepositoryProvider).deleteEmployee(id);
      state.whenData((current) {
        final updatedList = current.where((emp) => emp.id != id).toList();
        state = AsyncValue.data(updatedList);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
