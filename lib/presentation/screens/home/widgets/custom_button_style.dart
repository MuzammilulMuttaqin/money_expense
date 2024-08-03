import 'package:flutter/material.dart';
import 'package:money_expense/shared/color_style.dart';

ButtonStyle customButtonStyle({required bool isEnabled}) {
  return ElevatedButton.styleFrom(
    minimumSize: Size(335, 50),
    backgroundColor: isEnabled ? ColorStyle.biruMuda2 : ColorStyle.grey,
    side: BorderSide(
      color: isEnabled ? ColorStyle.biruMuda2 : ColorStyle.grey,
      width: 2.0,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}