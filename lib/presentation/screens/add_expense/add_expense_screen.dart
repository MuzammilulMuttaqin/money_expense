import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_expense/generated/assets.dart';
import 'package:money_expense/presentation/screens/add_expense/widgets/add_expense.dart';
import 'package:money_expense/presentation/screens/add_expense/widgets/date_utils.dart';
import 'package:money_expense/presentation/screens/add_expense/widgets/show_category_modal_bottom_sheet.dart';
import 'package:money_expense/presentation/screens/home/widgets/custom_button_style.dart';
import 'package:money_expense/presentation/screens/add_expense/widgets/input_decoration.dart';
import 'package:money_expense/presentation/screens/home/widgets/thousands_separator_input_formatter.dart';
import 'package:money_expense/shared/color_style.dart';
import 'widgets/select_date.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  AddExpenseScreenState createState() => AddExpenseScreenState();
}

class AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _category = 'Makanan';
  String? _categoryIconPath = Assets.assetsMakanan;
  DateTime _date = DateTime.now();
  double _amount = 0.0;
  Color _iconColor = ColorStyle.orange;
  final TextEditingController _amountController = TextEditingController();

  bool get isFormValid {
    return _name.isNotEmpty && _category.isNotEmpty && _amount > 0;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.assetsIconBack,
            color: const Color(0xff4F4F4F),
            height: 24.0,
            width: 24.0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Tambah Pengeluaran Baru',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration:
                    customInputDecoration(labelText: 'Nama Pengeluaran'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama pengeluaran tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: customInputDecoration(
                  labelText: '',
                  prefixIconPath: _categoryIconPath,
                  iconColor: _iconColor,
                  additionalSuffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: ColorStyle.grey,
                      child: SvgPicture.asset(
                        Assets.assetsBackLeft,
                        color: ColorStyle.grey3,
                      ),
                    ),
                  ),
                ),
                controller: TextEditingController(text: _category),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori tidak boleh kosong';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () {
                  showCategoryModalBottomSheet(context,
                      (name, iconPath, color) {
                    setState(() {
                      _category = name;
                      _categoryIconPath = iconPath;
                      _iconColor = color;
                    });
                  });
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  selectDate(
                    context: context,
                    initialDate: _date,
                    onDateSelected: (selectedDate) {
                      setState(() {
                        _date = selectedDate;
                      });
                    },
                  );
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: customInputDecoration(
                        labelText: '',
                        suffixIconPath: Assets.assetsCalendar,
                        iconColor: const Color(0xffBDBDBD)),
                    controller: TextEditingController(text: formatDate(_date)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal pengeluaran tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: customInputDecoration(
                  labelText: 'Nominal',
                  prefixText: 'Rp. ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
                onChanged: (value) {
                  final numericValue = value.replaceAll(RegExp(r'\D'), '');
                  setState(() {
                    _amount = double.tryParse(numericValue) ?? 0.0;
                  });
                },
                validator: (value) {
                  final numericValue =
                      value?.replaceAll(RegExp(r'\D'), '') ?? '';
                  if (numericValue.isEmpty) {
                    return 'Nominal tidak boleh kosong';
                  }
                  if (double.tryParse(numericValue) == null) {
                    return 'Nominal tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isFormValid ? _handleAddExpense : null,
                style: customButtonStyle(isEnabled: isFormValid).copyWith(
                  minimumSize:
                      MaterialStateProperty.all(const Size(double.infinity, 56.0)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16.0)),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAddExpense() {
    addExpense(
      context: context,
      name: _name,
      category: _category,
      date: _date,
      amount: _amount,
      onSuccess: () {
        Navigator.pop(context);
      },
    );
  }
}
