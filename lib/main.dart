import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/src/domain/theme/custome_theme.dart';
import 'package:riverpod_app/src/view/screens/employee/employee_list.dart';

/*void main() {
  runApp(const MyApp());
}*/
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Details',
      theme: CustomThemes.lightTheme(context), // Light theme
      home: const EmployeeList(),
    );
  }
}
