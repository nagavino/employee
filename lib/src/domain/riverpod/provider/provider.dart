// provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/models/employee/employee_model.dart';
import '../../repository/employee_repository/employee_repository.dart';
import '../notifier/employee/employee_notifier.dart';

final employeeRepositoryProvider = Provider<EmployeeRepository>((ref) {
  return EmployeeRepository();
});

final employeeListProvider =
    StateNotifierProvider<EmployeeNotifier, AsyncValue<List<Employee>>>((ref) {
  return EmployeeNotifier(ref);
});
