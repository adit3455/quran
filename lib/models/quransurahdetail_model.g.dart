// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quransurahdetail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuranSurahDetailModelAdapter extends TypeAdapter<QuranSurahDetailModel> {
  @override
  final int typeId = 0;

  @override
  QuranSurahDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuranSurahDetailModel(
      nomor: fields[0] as int?,
      nama: fields[1] as String?,
      namaLatin: fields[2] as String?,
      jumlahAyat: fields[3] as int?,
      tempatTurun: fields[4] as String?,
      arti: fields[5] as String?,
      deskripsi: fields[6] as String?,
      audio: fields[7] as String?,
      status: fields[8] as bool?,
      ayat: (fields[9] as List?)?.cast<Ayat>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuranSurahDetailModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.nomor)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.namaLatin)
      ..writeByte(3)
      ..write(obj.jumlahAyat)
      ..writeByte(4)
      ..write(obj.tempatTurun)
      ..writeByte(5)
      ..write(obj.arti)
      ..writeByte(6)
      ..write(obj.deskripsi)
      ..writeByte(7)
      ..write(obj.audio)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.ayat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuranSurahDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AyatAdapter extends TypeAdapter<Ayat> {
  @override
  final int typeId = 1;

  @override
  Ayat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ayat(
      id: fields[0] as int?,
      surah: fields[1] as int?,
      nomor: fields[2] as int?,
      ar: fields[3] as String?,
      tr: fields[4] as String?,
      idn: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Ayat obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.surah)
      ..writeByte(2)
      ..write(obj.nomor)
      ..writeByte(3)
      ..write(obj.ar)
      ..writeByte(4)
      ..write(obj.tr)
      ..writeByte(5)
      ..write(obj.idn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AyatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
