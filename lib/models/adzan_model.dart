class AdzanModel {
  String? tanggal;
  String? imsyak;
  String? shubuh;
  String? terbit;
  String? dhuha;
  String? dzuhur;
  String? ashr;
  String? magrib;
  String? isya;

  AdzanModel(
      {this.tanggal,
      this.imsyak,
      this.shubuh,
      this.terbit,
      this.dhuha,
      this.dzuhur,
      this.ashr,
      this.magrib,
      this.isya});

  AdzanModel.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    imsyak = json['imsyak'];
    shubuh = json['shubuh'];
    terbit = json['terbit'];
    dhuha = json['dhuha'];
    dzuhur = json['dzuhur'];
    ashr = json['ashr'];
    magrib = json['magrib'];
    isya = json['isya'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tanggal'] = tanggal;
    data['imsyak'] = imsyak;
    data['shubuh'] = shubuh;
    data['terbit'] = terbit;
    data['dhuha'] = dhuha;
    data['dzuhur'] = dzuhur;
    data['ashr'] = ashr;
    data['magrib'] = magrib;
    data['isya'] = isya;
    return data;
  }
}
