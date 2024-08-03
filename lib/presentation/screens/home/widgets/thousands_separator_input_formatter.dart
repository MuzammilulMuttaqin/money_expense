import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _numberFormat = NumberFormat.decimalPattern('id');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll('.', '');
    final intSelectionIndex = newText.length - oldValue.selection.start;

    final formattedText = _numberFormat.format(int.parse(newText.isEmpty ? '0' : newText));

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length - intSelectionIndex),
    );
  }
}
