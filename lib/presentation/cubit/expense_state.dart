part of 'expense_cubit.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpensesLoaded extends ExpenseState {
  final List<Expense> expenses;

  const ExpensesLoaded(this.expenses);

  @override
  List<Object> get props => [expenses];
}

