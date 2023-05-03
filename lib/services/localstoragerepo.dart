import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_app/models/quransurahdetail_model.dart';
import 'package:quran_app/services/baselocalstorageservive.dart';

class LocalStorageRepository extends BaseLocalStorageService {
  String boxName = 'bookmakrs_ayat';

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Ayat>(boxName);
    return box;
  }

  @override
  List<Ayat> getBookmarks(Box box) {
    return box.values.toList() as List<Ayat>;
  }

  @override
  Future<void> addAyatToBookmarks(Ayat ayat) async {
    Box box = await Hive.openBox<Ayat>(boxName);
    await box.add(ayat);
  }

  @override
  Future<void> removeAyatToBookmarks(Ayat ayat, int index) async {
    Box box = await Hive.openBox<Ayat>(boxName);

    await box.deleteAt(index);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }
}
