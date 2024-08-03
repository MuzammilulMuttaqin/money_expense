import 'package:flutter/material.dart';
import 'package:money_expense/data/category.dart';
import 'package:money_expense/presentation/screens/add_expense/widgets/build_category_item.dart';
import 'package:money_expense/presentation/screens/home/widgets/get_category_color.dart';
import 'package:money_expense/presentation/screens/home/widgets/get_category_icon.dart';

void showCategoryModalBottomSheet(
    BuildContext context,
    Function(String, String, Color) onCategorySelected
    ) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Text(
                    'Pilih Kategori',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 28.0),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                shrinkWrap: true,
                children: [
                  for (var categoryName in [
                    'Makanan', 'Internet', 'Edukasi', 'Hadiah', 'Transportasi',
                    'Belanja', 'Alat Rumah', 'Olahraga', 'Hiburan'
                  ])
                    buildCategoryItem(
                      context,
                      Category(categoryName, getCategoryIcon(categoryName), getCategoryColor(categoryName)),
                      onCategorySelected,
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

