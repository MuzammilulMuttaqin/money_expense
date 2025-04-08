import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_expense/data/models/expense.dart';
import 'package:money_expense/presentation/cubit/expense_cubit.dart';
import 'package:money_expense/presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());

  final expenseBox = await Hive.openBox<Expense>('expenses');
  final totalExpensesBox = await Hive.openBox<double>('totalExpenses');
  await initializeDateFormatting('id_ID', null);
  runApp(MyApp(expenseBox: expenseBox, totalExpensesBox: totalExpensesBox));
}

class MyApp extends StatelessWidget {
  final Box<Expense> expenseBox;
  final Box<double> totalExpensesBox;

  const MyApp({super.key, required this.expenseBox, required this.totalExpensesBox});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpenseCubit(expenseBox, totalExpensesBox),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
