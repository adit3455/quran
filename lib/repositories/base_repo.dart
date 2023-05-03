import 'dart:async';

import '../models/export_models.dart';

abstract class BaseRepositories {
  Future<List<QuranSurahModel>> getAllSurah();
  Future<List<QuranSurahModel>> getAllSurahSearch(String text);
  Future<QuranSurahDetailModel> getDetailSurah({required int index});
  Future<List<DoaModel>> getDoa();
  Future<List<AdzanModel>> getWaktuAdzan();
  Future<FeedModel> getFeed();
  Future<List<YasinModel>> getYasin();
}
