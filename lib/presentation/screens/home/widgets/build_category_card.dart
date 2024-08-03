import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_expense/presentation/screens/home/widgets/format_nominal.dart';

Widget buildCategoryCard(
    String title, double amount, String iconPath, Color iconColor) {
  return Container(
    width: 120,
    height: 120,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: iconColor,
            child: SvgPicture.asset(
              iconPath,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff828282)),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 4),
          Text(
            formatNominal(amount),
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333)),
          ),
        ],
      ),
    ),
  );
}