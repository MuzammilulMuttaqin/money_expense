import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_expense/presentation/cubit/expense_cubit.dart';
import 'package:money_expense/presentation/screens/home/widgets/build_expense_shimmer.dart';
import 'package:money_expense/presentation/screens/home/widgets/get_category_color.dart';
import 'package:money_expense/presentation/screens/home/widgets/get_category_icon.dart';
import 'package:money_expense/shared/color_style.dart';
import 'package:money_expense/presentation/screens/home/widgets/format_nominal.dart';

Widget buildExpenseList(BuildContext context, String title, bool today) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 8),
      BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is ExpensesLoaded) {
            final expenses = state.expenses.where((expense) {
              final now = DateTime.now();
              if (today) {
                return expense.date.day == now.day &&
                    expense.date.month == now.month &&
                    expense.date.year == now.year;
              } else {
                final yesterday = now.subtract(const Duration(days: 1));
                return expense.date.day == yesterday.day &&
                    expense.date.month == yesterday.month &&
                    expense.date.year == yesterday.year;
              }
            }).toList();

            expenses.sort((a, b) => b.date.compareTo(a.date));

            if (expenses.isEmpty) {
              return const Center(
                child: Text('Data tidak ada'),
              );
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return Container(
                    width: 335,
                    height: 67,
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              getCategoryIcon(expense.category),
                              color: getCategoryColor(expense.category),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              expense.name,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorStyle.grey2),
                            ),
                          ],
                        ),
                        Text(
                          'Rp. ${formatNominal(expense.amount)}',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: ColorStyle.grey2),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return buildExpenseShimmer();
        },
      ),
    ],
  );
}
