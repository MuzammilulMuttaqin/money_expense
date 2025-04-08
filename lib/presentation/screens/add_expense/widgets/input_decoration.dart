import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_expense/shared/color_style.dart';

InputDecoration customInputDecoration({
  required String labelText,
  String? suffixIconPath,
  Color? iconColor,
  Widget? additionalSuffixIcon,
  String? prefixIconPath,
  String? prefixText,
}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(color: ColorStyle.grey2),
    prefixText: prefixText,
    prefixIcon: prefixIconPath != null
        ? Padding(
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(
        prefixIconPath,
        color: iconColor ?? ColorStyle.grey2,
        height: 24.0,
        width: 24.0,
      ),
    )
        : null,
    suffixIcon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (suffixIconPath != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              suffixIconPath,
              color: iconColor ?? ColorStyle.grey2,
              height: 24.0,
              width: 24.0,
            ),
          ),
        if (additionalSuffixIcon != null)
          additionalSuffixIcon,
      ],
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorStyle.grey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorStyle.grey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: ColorStyle.grey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
  );
}


