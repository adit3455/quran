import 'package:hive_flutter/hive_flutter.dart';

part 'quransurahdetail_model.g.dart';

@HiveType(typeId: 0)
class QuranSurahDetailModel extends HiveObject {
  @HiveField(0)
  int? nomor;
  @HiveField(1)
  String? nama;
  @HiveField(2)
  String? namaLatin;
  @HiveField(3)
  int? jumlahAyat;
  @HiveField(4)
  String? tempatTurun;
  @HiveField(5)
  String? arti;
  @HiveField(6)
  String? deskripsi;
  @HiveField(7)
  String? audio;
  @HiveField(8)
  bool? status;
  @HiveField(9)
  List<Ayat>? ayat;

  QuranSurahDetailModel({
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
    this.status,
    this.ayat,
  });

  QuranSurahDetailModel.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor'];
    nama = json['nama'];
    namaLatin = json['nama_latin'];
    jumlahAyat = json['jumlah_ayat'];
    tempatTurun = json['tempat_turun'];
    arti = json['arti'];
    deskripsi = json['deskripsi'];
    audio = json['audio'];
    status = json['status'];
    if (json['ayat'] != null) {
      ayat = <Ayat>[];
      json['ayat'].forEach((v) {
        ayat!.add(Ayat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nomor'] = nomor;
    data['nama'] = nama;
    data['nama_latin'] = namaLatin;
    data['jumlah_ayat'] = jumlahAyat;
    data['tempat_turun'] = tempatTurun;
    data['arti'] = arti;
    data['deskripsi'] = deskripsi;
    data['audio'] = audio;
    data['status'] = status;
    if (ayat != null) {
      data['ayat'] = ayat!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

@HiveType(typeId: 1)
class Ayat extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? surah;
  @HiveField(2)
  int? nomor;
  @HiveField(3)
  String? ar;
  @HiveField(4)
  String? tr;
  @HiveField(5)
  String? idn;

  Ayat({this.id, this.surah, this.nomor, this.ar, this.tr, this.idn});

  Ayat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surah = json['surah'];
    nomor = json['nomor'];
    ar = json['ar'];
    tr = json['tr'];
    idn = json['idn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['surah'] = surah;
    data['nomor'] = nomor;
    data['ar'] = ar;
    data['tr'] = tr;
    data['idn'] = idn;
    return data;
  }
}
