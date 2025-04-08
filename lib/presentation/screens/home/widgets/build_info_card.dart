import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:money_expense/presentation/cubit/expense_cubit.dart';
import 'package:money_expense/presentation/screens/home/widgets/format_nominal.dart';

Widget buildInfoCard(BuildContext context,
    {required String title, required Color color}) {
  return Expanded(
    child: BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        final expenseCubit = BlocProvider.of<ExpenseCubit>(context);
        final todayTotal = expenseCubit.getTodayTotal();
        final monthTotal = expenseCubit.getMonthTotal();
        final amount = title.contains('hari ini') ? todayTotal : monthTotal;

        return Container(
          height: 97,
          width: 158,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
              const Spacer(),
              Text(
                'Rp ${formatNominal(amount)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}