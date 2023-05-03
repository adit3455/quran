import 'package:hive_flutter/hive_flutter.dart';

import '../models/export_models.dart';

abstract class BaseLocalStorageService {
  Future<Box> openBox();
  List<Ayat> getBookmarks(Box box);
  Future<void> addAyatToBookmarks(Ayat ayat);
  Future<void> removeAyatToBookmarks(Ayat ayat, int index);
  Future<void> clearWishlist(Box box);
}
