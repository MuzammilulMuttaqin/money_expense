import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
}