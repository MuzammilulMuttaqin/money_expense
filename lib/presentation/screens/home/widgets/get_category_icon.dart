import 'package:money_expense/generated/assets.dart';

String getCategoryIcon(String category) {
  switch (category) {
    case 'Makanan':
      return Assets.assetsMakanan;
    case 'Internet':
      return Assets.assetsInternet;
    case 'Transportasi':
      return Assets.assetsTransport;
    case 'Edukasi':
      return Assets.assetsEdukasi;
    case 'Hadiah':
      return Assets.assetsGift;
    case 'Belanja':
      return Assets.assetsBelanja;
    case 'Alat Rumah':
      return Assets.assetsRumah;
    case 'Olahraga':
      return Assets.assetsOlahraga;
    case 'Hiburan':
      return Assets.assetsHiburan;
    default:
      return '';
  }
}