class QuranSurahDetailModel {
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;
  bool? status;
  List<Ayat>? ayat;
  SuratSelanjutnya? suratSelanjutnya;
  SuratSelanjutnya? suratSebelumnya;

  QuranSurahDetailModel(
      {this.nomor,
      this.nama,
      this.namaLatin,
      this.jumlahAyat,
      this.tempatTurun,
      this.arti,
      this.deskripsi,
      this.audio,
      this.status,
      this.ayat,
      this.suratSelanjutnya,
      this.suratSebelumnya});

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
    suratSelanjutnya = SuratSelanjutnya.fromJson(json['surat_selanjutnya']);
    suratSebelumnya = SuratSelanjutnya.fromJson(json['surat_sebelumnya']);
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
    if (suratSelanjutnya != null) {
      data['surat_selanjutnya'] = suratSelanjutnya!.toJson();
    }
    if (suratSebelumnya != null) {
      data['surat_sebelumnya'] = suratSebelumnya!.toJson();
    }
    return data;
  }
}

class Ayat {
  int? id;
  int? surah;
  int? nomor;
  String? ar;
  String? tr;
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

class SuratSelanjutnya {
  int? id;
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;

  SuratSelanjutnya(
      {this.id,
      this.nomor,
      this.nama,
      this.namaLatin,
      this.jumlahAyat,
      this.tempatTurun,
      this.arti,
      this.deskripsi,
      this.audio});

  SuratSelanjutnya.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomor = json['nomor'];
    nama = json['nama'];
    namaLatin = json['nama_latin'];
    jumlahAyat = json['jumlah_ayat'];
    tempatTurun = json['tempat_turun'];
    arti = json['arti'];
    deskripsi = json['deskripsi'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nomor'] = nomor;
    data['nama'] = nama;
    data['nama_latin'] = namaLatin;
    data['jumlah_ayat'] = jumlahAyat;
    data['tempat_turun'] = tempatTurun;
    data['arti'] = arti;
    data['deskripsi'] = deskripsi;
    data['audio'] = audio;
    return data;
  }
}
