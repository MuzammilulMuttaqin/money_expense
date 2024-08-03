import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_expense/data/category.dart';
import 'package:money_expense/shared/color_style.dart';

Widget buildCategoryItem(
    BuildContext context,
    Category category,
    Function(String, String, Color) onCategorySelected
    ) {
  return GestureDetector(
    onTap: () {
      onCategorySelected(category.name, category.iconPath, category.color);
      Navigator.pop(context);
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: category.color,
          child: SvgPicture.asset(
            category.iconPath,
            height: 24,
            width: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          category.name,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorStyle.grey3),
        ),
      ],
    ),
  );
}