import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../infrastructure/models/employee/employee_model.dart';

class EmployeeRepository {
  // Use your HTTP URL (make sure to use http:// not https://)
  static const String baseUrl = 'http://nagavino2.free.nf/api.php';

  final Dio dio;

  EmployeeRepository({Dio? dio})
      : dio = dio ?? Dio(BaseOptions(connectTimeout: Duration(seconds: 10)));

  Future<List<Employee>> fetchAllEmployees() async {
    const url = '$baseUrl?action=fetchAll';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        // If response.data is already a List, no need to decode again
        final data = response.data as List;
        return data.map((e) => Employee.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch employees');
      }
    } on DioError catch (e) {
      // Print out detailed error for debugging
      print('Dio error: $e');
      throw Exception('Failed to fetch employees: ${e.message}');
    }
  }

  Future<Employee> fetchEmployee(int id) async {
    final url = '$baseUrl?action=fetchOne&id=$id';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return Employee.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch employee');
      }
    } on DioError catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to fetch employee: ${e.message}');
    }
  }

  Future<Employee> addEmployee(Employee employee) async {
    final url = '$baseUrl?action=add';
    try {
      final response = await dio.post(url,
          data: jsonEncode(employee.toJson()),
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response.statusCode == 201) {
        return Employee.fromJson(response.data);
      } else {
        throw Exception('Failed to add employee');
      }
    } on DioError catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to add employee: ${e.message}');
    }
  }

  Future<Employee> updateEmployee(Employee employee) async {
    if (employee.id == null) {
      throw Exception('Employee ID is null');
    }
    final url = '$baseUrl?action=update&id=${employee.id}';
    try {
      final response = await dio.put(url,
          data: jsonEncode(employee.toJson()),
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response.statusCode == 200) {
        return Employee.fromJson(response.data);
      } else {
        throw Exception('Failed to update employee');
      }
    } on DioError catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to update employee: ${e.message}');
    }
  }

  Future<void> deleteEmployee(int id) async {
    final url = '$baseUrl?action=delete&id=$id';
    try {
      final response = await dio.delete(url);
      if (response.statusCode != 204) {
        throw Exception('Failed to delete employee');
      }
    } on DioError catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to delete employee: ${e.message}');
    }
  }
}
