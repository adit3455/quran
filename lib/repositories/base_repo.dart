import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/export_models.dart';

abstract class BaseRepositories {
  getAllSurah() {}
  getDetailSurah({required int index}) {}
  getDoa() {}
  getWaktuAdzan() {}
  getFeed() {}
}

class QuranSurah extends BaseRepositories {
  @override
  Future<List<QuranSurahModel>> getAllSurah() async {
    var response = await Dio().get(
      "https://equran.id/api/surat",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    List obj = response.data;
    List<QuranSurahModel> data =
        obj.map((data) => QuranSurahModel.fromJson(data)).toList();
    return data;
  }

  @override
  Future<QuranSurahDetailModel> getDetailSurah({required int index}) async {
    var response = await Dio().get(
      "https://equran.id/api/surat/$index",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    Map<String, dynamic> obj = response.data;
    QuranSurahDetailModel data = QuranSurahDetailModel.fromJson(obj);
    return data;
  }

  @override
  Future<List<DoaModel>> getDoa() async {
    var response = await Dio().get(
      "https://doa-doa-api-ahmadramadhan.fly.dev/api",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    List obj = response.data;
    List<DoaModel> data = obj.map((data) => DoaModel.fromJson(data)).toList();

    return data;
  }

  @override
  Future<List<AdzanModel>> getWaktuAdzan() async {
    String monthNow = DateTime.now().month.toString().padLeft(2, '0');
    String yearNow = DateTime.now().year.toString();

    var response = await Dio().get(
      "https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/medan/$yearNow/$monthNow.json",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    List obj = jsonDecode(response.data);

    List<AdzanModel> data =
        obj.map((data) => AdzanModel.fromJson(data)).toList();

    return data;
  }

  @override
  Future<FeedModel> getFeed() async {
    var response = await Dio().get(
      "https://newsapi.org/v2/everything?language=id&q=muslim&apiKey=3aa072174842419cac5216043f89a531",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    Map<String, dynamic> obj = response.data;
    FeedModel data = FeedModel.fromJson(obj);
    return data;
  }
}
