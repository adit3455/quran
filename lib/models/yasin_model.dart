// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class YasinModel extends Equatable {
  final String ayat;
  final String latin;
  final String arti;
  const YasinModel({
    required this.ayat,
    required this.latin,
    required this.arti,
  });

  YasinModel copyWith({
    String? ayat,
    String? latin,
    String? arti,
  }) {
    return YasinModel(
      ayat: ayat ?? this.ayat,
      latin: latin ?? this.latin,
      arti: arti ?? this.arti,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ayat': ayat,
      'latin': latin,
      'arti': arti,
    };
  }

  factory YasinModel.fromMap(Map<String, dynamic> map) {
    return YasinModel(
      ayat: map['ayat'] as String,
      latin: map['latin'] as String,
      arti: map['arti'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory YasinModel.fromJson(String source) =>
      YasinModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ayat, latin, arti];
}
