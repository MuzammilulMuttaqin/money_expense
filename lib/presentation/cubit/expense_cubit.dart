import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:money_expense/data/models/expense.dart';

part 'expense_state.dart';
class ExpenseCubit extends Cubit<ExpenseState> {
  final Box<Expense> expenseBox;
  final Box<double> totalExpensesBox;

  ExpenseCubit(this.expenseBox, this.totalExpensesBox) : super(ExpenseInitial()) {
    loadExpenses();
  }

  void loadExpenses() {
    final expenses = expenseBox.values.toList();
    emit(ExpensesLoaded(expenses));
    _updateTotalExpenses();
  }

  void addExpense(Expense expense) {
    expenseBox.add(expense);
    _updateTotalExpenses();
  }

  void deleteExpense(int index) {
    expenseBox.deleteAt(index);
    _updateTotalExpenses();
  }

  void _updateTotalExpenses() {
    final today = DateTime.now();
    final todayExpenses = expenseBox.values.where((expense) =>
    expense.date.day == today.day &&
        expense.date.month == today.month &&
        expense.date.year == today.year);
    final todayAmount = todayExpenses.fold(0.0, (sum, expense) => sum + expense.amount);

    final monthExpenses = expenseBox.values.where((expense) =>
    expense.date.month == today.month &&
        expense.date.year == today.year);
    final monthAmount = monthExpenses.fold(0.0, (sum, expense) => sum + expense.amount);

    totalExpensesBox.put('today', todayAmount);
    totalExpensesBox.put('month', monthAmount);

    emit(ExpensesLoaded(expenseBox.values.toList())); // Emit new expenses to notify UI
  }

  double getTodayTotal() => totalExpensesBox.get('today', defaultValue: 0.0) ?? 0.0;
  double getMonthTotal() => totalExpensesBox.get('month', defaultValue: 0.0) ?? 0.0;
}


