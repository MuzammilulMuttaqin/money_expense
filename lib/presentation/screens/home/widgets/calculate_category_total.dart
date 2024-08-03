import 'package:money_expense/data/models/expense.dart';

Map<String, CategoryData> calculateCategoryTotals(List<Expense> expenses) {
  final Map<String, CategoryData> categoryDataMap = {};

  for (var expense in expenses) {
    final category = expense.category;

    if (!categoryDataMap.containsKey(category)) {
      categoryDataMap[category] = CategoryData(
        totalAmount: 0.0,
        latestUpdate: expense.date,
      );
    }

    final currentCategoryData = categoryDataMap[category]!;
    categoryDataMap[category] = CategoryData(
      totalAmount: currentCategoryData.totalAmount + expense.amount,
      latestUpdate: expense.date.isAfter(currentCategoryData.latestUpdate)
          ? expense.date
          : currentCategoryData.latestUpdate,
    );
  }

  return categoryDataMap;
}
class CategoryData {
  final double totalAmount;
  final DateTime latestUpdate;

  CategoryData({
    required this.totalAmount,
    required this.latestUpdate,
  });
}
