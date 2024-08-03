import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_expense/presentation/screens/home/widgets/build_expense_list.dart';
import 'package:money_expense/presentation/screens/add_expense/add_expense_screen.dart';
import 'package:money_expense/presentation/cubit/expense_cubit.dart';
import 'package:money_expense/shared/color_style.dart';

import 'widgets/build_category_card.dart';
import 'widgets/build_info_card.dart';
import 'widgets/calculate_category_total.dart';
import 'widgets/get_category_color.dart';
import 'widgets/get_category_icon.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final expenseCubit = BlocProvider.of<ExpenseCubit>(context);
    expenseCubit.loadExpenses();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      backgroundColor: Color(0xffFFFFFF),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {
                if (state is ExpensesLoaded) {
                  final expenses = state.expenses;
                  final categoryTotals = calculateCategoryTotals(expenses);
                  final sortedCategories = categoryTotals.entries.toList()
                    ..sort((a, b) => b.value.latestUpdate.compareTo(a.value.latestUpdate));
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Halo, User!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Jangan lupa catat keuanganmu setiap hari!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              buildInfoCard(
                                context,
                                title: 'Pengeluaranmu hari ini',
                                color: Colors.blue,
                              ),
                              SizedBox(width: 19),
                              buildInfoCard(
                                context,
                                title: 'Pengeluaranmu bulan ini',
                                color: ColorStyle.teal,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Pengeluaran berdasarkan kategori',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 140,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...sortedCategories.map((entry) {
                                    final category = entry.key;
                                    final amount = entry.value.totalAmount;
                                    final iconPath = getCategoryIcon(category);
                                    final color = getCategoryColor(category);
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20.0), // Adds 20px space to the right of each card
                                      child: buildCategoryCard(
                                        category,
                                        amount,
                                        iconPath,
                                        color,
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          buildExpenseList(context, 'Hari ini', true),
                          SizedBox(height: 16),
                          buildExpenseList(context, 'Kemarin', false),
                        ],
                      ),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          ).then((_) {
            BlocProvider.of<ExpenseCubit>(context).loadExpenses();
          });
        },
        backgroundColor: Color(0xff0A97B0),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
