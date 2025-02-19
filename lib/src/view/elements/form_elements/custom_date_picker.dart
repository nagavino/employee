// custom_date_picker.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/constants.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateSelected;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void _pickDate() async {
    DateTime initialDate = _selectedDate ?? DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayDate = _selectedDate != null
        ? DateFormat('d MMM yyyy').format(_selectedDate!)
        : 'Select date';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(Constants.inputBorderRadius),
          onTap: _pickDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
            decoration: BoxDecoration(
              border: Border.all(color: inputBorderColor),
              borderRadius: BorderRadius.circular(Constants.inputBorderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: Constants.inputIconSize,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    displayDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: _selectedDate == null ? inputTextColor : black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
