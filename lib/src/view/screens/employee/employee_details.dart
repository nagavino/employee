// employee_details.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:riverpod_app/src/view/elements/divider/custom_divider_view.dart';
import '../../../domain/constants.dart';
import '../../../domain/riverpod/provider/provider.dart';
import '../../../domain/shared_preference/helper.dart';
import '../../../infrastructure/models/employee/employee_model.dart';
import '../../elements/bottom_sheet/role_bottom_sheet.dart';
import '../../elements/form_elements/custom_date_picker.dart';

class EmployeeDetails extends ConsumerStatefulWidget {
  final Employee? employee;
  const EmployeeDetails({super.key, this.employee});

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends ConsumerState<EmployeeDetails> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _roleController;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee?.name ?? '');
    _roleController = TextEditingController(text: widget.employee?.role ?? '');
    _startDate = widget.employee?.startDate ?? DateTime.now();
    _endDate = widget.employee?.endDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _saveEmployee() {
    if (_formKey.currentState!.validate()) {
      final newEmployee = Employee(
        id: widget.employee?.id,
        name: _nameController.text.trim(),
        role: _roleController.text.trim(),
        startDate: _startDate ?? DateTime.now(),
        endDate: _endDate,
      );

      if (widget.employee == null) {
        // Add new employee
        ref.read(employeeListProvider.notifier).addEmployee(newEmployee);
      } else {
        // Update existing employee
        ref.read(employeeListProvider.notifier).updateEmployee(newEmployee);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.employee != null;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
              isEditing ? 'Edit Employee Details' : 'Add Employee Details'),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Constants.sidePaddingAll),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Employee Name Field
                        Responsive(
                          runSpacing: Constants.inputBoxVerticalSpace,
                          children: [
                            Div(
                              divison: Helper.divisionValue(6,
                                  xs: 12, s: 12, m: 6, l: 6, xl: 6),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: Helper.responsiveScreenSize(context,
                                      type: 'width',
                                      typeValue: 'no',
                                      deviceSize: tabletXs,
                                      success:
                                          Constants.inputBoxHorizontalSpace,
                                      /* tablet */
                                      fail: 0.0),
                                ),
                                child: TextFormField(
                                  controller: _nameController,
                                  autofocus: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                      color:
                                          black), // Sets the input text color
                                  decoration: const InputDecoration(
                                    labelText: 'Employee name',
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      size: Constants.inputIconSize,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Enter employee name'
                                          : null,
                                ),
                              ),
                            ),
                            Div(
                              divison: Helper.divisionValue(6,
                                  xs: 12, s: 12, m: 6, l: 6, xl: 6),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Helper.responsiveScreenSize(context,
                                      type: 'width',
                                      typeValue: 'no',
                                      deviceSize: tabletXs,
                                      success:
                                          Constants.inputBoxHorizontalSpace,
                                      /* tablet */
                                      fail: 0.0),
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    final selectedRole =
                                        await showModalBottomSheet<String>(
                                      context: context,
                                      enableDrag: true,
                                      /*shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25),
                                      )),*/
                                      builder: (_) => const RoleBottomSheet(),
                                    );
                                    if (selectedRole != null) {
                                      setState(() {
                                        _roleController.text = selectedRole;
                                      });
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      autofocus: false,
                                      autocorrect: false,
                                      controller: _roleController,
                                      style: TextStyle(
                                          color:
                                              black), // Sets the input text color
                                      decoration: InputDecoration(
                                        labelText: 'Select role',
                                        prefixIcon: const Icon(
                                          Icons.work_outline,
                                          size: Constants.inputIconSize,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        border: const OutlineInputBorder(),
                                      ),
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? 'Select a role'
                                              : null,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: Constants.inputBoxVerticalSpace),

                        // Date Range Pickers
                        Row(
                          children: [
                            Expanded(
                              child: CustomDatePicker(
                                label: 'Start date',
                                initialDate: _startDate,
                                onDateSelected: (date) =>
                                    setState(() => _startDate = date),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 22),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: CustomDatePicker(
                                label: 'End date',
                                initialDate: _endDate,
                                onDateSelected: (date) =>
                                    setState(() => _endDate = date),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Action Buttons
            CustomDividerView(
              color: Theme.of(context).dividerColor,
              dividerHeight: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.sidePaddingAll),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: Constants.btnHorizontalSpace),
                  ElevatedButton(
                    onPressed: _saveEmployee,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
