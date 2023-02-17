// ignore_for_file: public_member_api_docs, sort_constructors_first

class DziarahModel {
  final String judul;
  final List<String> ayat;
  final List<String> latin;
  final List<String> arti;
  DziarahModel({
    required this.judul,
    required this.ayat,
    required this.latin,
    required this.arti,
  });

  factory DziarahModel.fromJson(Map<String, dynamic> data) {
    return DziarahModel(
      judul: data['judul'],
      ayat: data['ayat'],
      latin: data['latin'],
      arti: data['arti'],
    );
  }
}
