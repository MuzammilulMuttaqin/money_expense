import 'package:flutter/material.dart';

Future<void> selectDate({
  required BuildContext context,
  required DateTime initialDate,
  required Function(DateTime) onDateSelected,
}) async {
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if (selectedDate != null && selectedDate != initialDate) {
    onDateSelected(selectedDate);
  }
}
