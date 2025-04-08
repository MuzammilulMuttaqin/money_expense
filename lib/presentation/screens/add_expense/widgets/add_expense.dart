import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_expense/data/models/expense.dart';
import 'package:money_expense/presentation/cubit/expense_cubit.dart';

void addExpense({
  required BuildContext context,
  required String name,
  required String category,
  required DateTime date,
  required double amount,
  required Function() onSuccess,
}) {
  final expense = Expense()
    ..name = name
    ..category = category
    ..date = date
    ..amount = amount;

  context.read<ExpenseCubit>().addExpense(expense);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Pengeluaran berhasil ditambahkan')),
  );

  onSuccess();
}
