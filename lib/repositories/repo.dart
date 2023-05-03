import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:quran_app/repositories/base_repo.dart';
import 'package:web_scraper/web_scraper.dart';
import '../models/export_models.dart';

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
  Future<List<QuranSurahModel>> getAllSurahSearch(String text) async {
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
        obj.map((e) => QuranSurahModel.fromJson(e)).toList();

    List<QuranSurahModel> listOfSearched = data
        .where((element) =>
            element.namaLatin!.toLowerCase().contains(text) ||
            element.namaLatin!.contains(text))
        .toList();

    return listOfSearched;
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

  @override
  Future<List<YasinModel>> getYasin() async {
    List<YasinModel> allYasin = [];
    const addressAyat = '#Konten-Tafsir-Per-Surat > p.text_Ayat';
    const addressLatin = '#Konten-Tafsir-Per-Surat > p.text_Latin';
    const addressArti = '#Konten-Tafsir-Per-Surat > p.text_Terjemah';
    final webScapper = WebScraper('https://tafsirweb.com');

    if (await webScapper.loadWebPage('/37171-surat-yasin.html')) {
      final ayat = webScapper.getElement(addressAyat, ['class']);
      final latin = webScapper.getElement(addressLatin, ['class']);
      final arti = webScapper.getElement(addressArti, ['class']);

      for (var i = 0; i < ayat.length; i++) {
        final ayats = ayat[i]['title'];
        final latins = latin[i]['title'];
        final artis = arti[i]['title'];
        final yasins = YasinModel(ayat: ayats, latin: latins, arti: artis);
        allYasin.add(yasins);
      }
    }
    return allYasin;
  }
}
