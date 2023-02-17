class DoaModel {
  String? id;
  String? doa;
  String? ayat;
  String? latin;
  String? artinya;

  DoaModel({this.id, this.doa, this.ayat, this.latin, this.artinya});

  DoaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doa = json['doa'];
    ayat = json['ayat'];
    latin = json['latin'];
    artinya = json['artinya'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doa'] = doa;
    data['ayat'] = ayat;
    data['latin'] = latin;
    data['artinya'] = artinya;
    return data;
  }
}
