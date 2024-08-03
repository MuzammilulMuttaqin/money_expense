import 'package:intl/intl.dart';

final NumberFormat numberFormat = NumberFormat.decimalPattern('id');

String formatNominal(double value) {
  return numberFormat.format(value);
}