import 'package:flutter/material.dart';
import 'package:money_expense/shared/color_style.dart';

Color getCategoryColor(String category) {
  switch (category) {
    case 'Makanan':
      return ColorStyle.kuning;
    case 'Internet':
      return ColorStyle.biruMuda;
    case 'Transportasi':
      return ColorStyle.ungu;
    case 'Edukasi':
      return ColorStyle.orange;
    case 'Hadiah':
      return ColorStyle.merah;
    case 'Belanja':
      return ColorStyle.hijau;
    case 'Alat Rumah':
      return ColorStyle.unguMuda;
    case 'Olahraga':
      return ColorStyle.biruTua1;
    case 'Hiburan':
      return ColorStyle.biruTua2;
    default:
      return ColorStyle.grey;
  }
}