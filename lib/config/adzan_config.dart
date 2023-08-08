import 'dart:async';

import '../models/export_models.dart';
import '../utils/export_utils.dart';

class AdzanConfig {
  Future<AdzanModel> adzanDateTime(
      Future<List<AdzanModel>> adzan, DateTime now) async {
    String timeAdzan = DateFormat('y-MM-dd').format(now);

    final iAdzan = await adzan;
    return iAdzan.firstWhere((element) => element.tanggal == timeAdzan);
  }

  DateTime adzanToDateTime(String s) {
    final hour = int.parse(s.substring(0, 2));
    final minute = int.parse(s.substring(3, 5));
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  Duration dateNowDurationType(DateTime now) =>
      Duration(hours: now.hour, minutes: now.minute, seconds: now.second);

  Duration get lateTimeHours =>
      const Duration(hours: 23, minutes: 59, seconds: 59);

  Duration adzanToDuration(String s) {
    final hour = int.parse(s.substring(0, 2));
    final minute = int.parse(s.substring(3, 5));

    return Duration(hours: hour, minutes: minute);
  }

  Duration dateTimeBackwardValue(AdzanModel adzan, DateTime now) {
    if (dateNowDurationType(now) >= adzanToDuration(adzan.isya!)) {
      return adzanToDateTime(adzan.shubuh!)
          .add(const Duration(days: 1))
          .difference(now);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.shubuh!)) {
      return adzanToDateTime(adzan.shubuh!).difference(now);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.dzuhur!)) {
      return adzanToDateTime(adzan.dzuhur!).difference(now);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.ashr!)) {
      return adzanToDateTime(adzan.ashr!).difference(now);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.magrib!)) {
      return adzanToDateTime(adzan.magrib!).difference(now);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.isya!)) {
      return adzanToDateTime(adzan.isya!).difference(now);
    }
    throw UnimplementedError();
  }

  String nameAdzanValue(AdzanModel adzan, DateTime now) {
    if (dateNowDurationType(now) >= adzanToDuration(adzan.isya!)) {
      return "Shubuh";
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.shubuh!)) {
      return "Shubuh";
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.dzuhur!)) {
      return "Dzuhur";
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.ashr!)) {
      return "Ashar";
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.magrib!)) {
      return "Maghrib";
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.isya!)) {
      return "Isya";
    }
    throw UnimplementedError();
  }

  Duration getLockDuration(AdzanModel adzan, DateTime now) {
    if (dateNowDurationType(now) >= adzanToDuration(adzan.isya!)) {
      return adzanToDuration(adzan.shubuh!);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.shubuh!)) {
      return adzanToDuration(adzan.shubuh!);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.dzuhur!)) {
      return adzanToDuration(adzan.dzuhur!);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.ashr!)) {
      return adzanToDuration(adzan.ashr!);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.magrib!)) {
      return adzanToDuration(adzan.magrib!);
    }
    if (dateNowDurationType(now) <= adzanToDuration(adzan.isya!)) {
      return adzanToDuration(adzan.isya!);
    }
    throw UnimplementedError();
  }

  // delete method below

  Duration getDurationAdzan(AdzanModel adzanModel, int eventTimeNow) {
    String stringConverter(String s) => s.toString().replaceAll(':', '');
    int intUnderTen(int timeNow) =>
        timeNow <= 10 ? (timeNow + 7) - (timeNow - 8) : timeNow;

    int parsingInthours(String s) =>
        int.parse(stringConverter(s.substring(0, 2)));
    int parsingIntminutes(String s) =>
        int.parse(stringConverter(s.substring(2, 5)));

    if (eventTimeNow >=
            int.parse(stringConverter(adzanModel.isya.toString())) &&
        eventTimeNow <= 2359) {
      return Duration(
          hours: intUnderTen(parsingInthours(adzanModel.shubuh.toString())),
          minutes: parsingIntminutes(adzanModel.shubuh.toString()));
    }
    if (int.parse(stringConverter(adzanModel.shubuh.toString())) >=
        eventTimeNow) {
      return Duration(
          hours: parsingInthours(adzanModel.shubuh.toString()),
          minutes: parsingIntminutes(adzanModel.shubuh.toString()));
    }
    if (int.parse(stringConverter(adzanModel.dzuhur.toString())) >=
        eventTimeNow) {
      return Duration(
          hours: parsingInthours(adzanModel.dzuhur.toString()),
          minutes: parsingIntminutes(adzanModel.dzuhur.toString()));
    }
    if (int.parse(stringConverter(adzanModel.ashr.toString())) >=
        eventTimeNow) {
      return Duration(
          hours: parsingInthours(adzanModel.ashr.toString()),
          minutes: parsingIntminutes(adzanModel.ashr.toString()));
    }
    if (int.parse(stringConverter(adzanModel.magrib.toString())) >=
        eventTimeNow) {
      return Duration(
          hours: parsingInthours(adzanModel.magrib.toString()),
          minutes: parsingIntminutes(adzanModel.magrib.toString()));
    }
    if (int.parse(stringConverter(adzanModel.isya.toString())) >=
        eventTimeNow) {
      return Duration(
          hours: parsingInthours(adzanModel.isya.toString()),
          minutes: parsingIntminutes(adzanModel.isya.toString()));
    }

    return const Duration(hours: 0, minutes: 0);
  }

  String getTimeNameAdzan(AdzanModel adzanModel, int eventTimeNow) {
    String stringConverter(String s) => s.toString().replaceAll(':', '');

    if (eventTimeNow >=
            int.parse(stringConverter(adzanModel.isya.toString())) &&
        eventTimeNow <= 2359) {
      return 'Shubuh';
    }
    if (int.parse(stringConverter(adzanModel.shubuh.toString())) >=
        eventTimeNow) {
      return 'Shubuh';
    }
    if (int.parse(stringConverter(adzanModel.dzuhur.toString())) >=
        eventTimeNow) {
      return 'Dzuhur';
    }
    if (int.parse(stringConverter(adzanModel.ashr.toString())) >=
        eventTimeNow) {
      return "Ashar";
    }
    if (int.parse(stringConverter(adzanModel.magrib.toString())) >=
        eventTimeNow) {
      return "Maghrib";
    }
    if (int.parse(stringConverter(adzanModel.isya.toString())) >=
        eventTimeNow) {
      return "Isya";
    }
    return 'Theres Something Wrong';
  }

  String changeTimeNameAdzan(AdzanModel adzanModel, int eventTimeNow) {
    String stringConverter(String s) => s.toString().replaceAll(':', '');

    if (int.parse(stringConverter(adzanModel.shubuh.toString())) >=
        eventTimeNow) {
      return 'Dzuhur';
    }
    if (int.parse(stringConverter(adzanModel.shubuh.toString())) <=
        eventTimeNow) {
      return 'Dzuhur';
    }
    if (int.parse(stringConverter(adzanModel.dzuhur.toString())) >=
        eventTimeNow) {
      return 'Ashar';
    }
    if (int.parse(stringConverter(adzanModel.ashr.toString())) >=
        eventTimeNow) {
      return 'Maghrib';
    }
    if (int.parse(stringConverter(adzanModel.magrib.toString())) >=
        eventTimeNow) {
      return 'Isya';
    }
    if (int.parse(stringConverter(adzanModel.isya.toString())) >=
        eventTimeNow) {
      return 'Shubuh';
    }
    return "There's Something Wrong";
  }

  Future<Duration?> changeTimeAdzan(
      AdzanModel adzanModel, int eventTimeNow) async {
    String stringConverter(String s) => s.toString().replaceAll(':', '');

    if (int.parse(stringConverter(adzanModel.shubuh.toString())) >=
        eventTimeNow) {
      return await Future.delayed(
          const Duration(seconds: 1),
          () => Duration(
              hours: int.parse(stringConverter(
                  adzanModel.dzuhur.toString().substring(0, 2))),
              minutes: int.parse(stringConverter(
                  adzanModel.dzuhur.toString().substring(2, 5)))));
    }
    if (int.parse(stringConverter(adzanModel.dzuhur.toString())) >=
        eventTimeNow) {
      return await Future.delayed(
          const Duration(seconds: 1),
          () => Duration(
              hours: int.parse(
                  stringConverter(adzanModel.ashr.toString().substring(0, 2))),
              minutes: int.parse(stringConverter(
                  adzanModel.ashr.toString().substring(2, 5)))));
    }
    if (int.parse(stringConverter(adzanModel.ashr.toString())) >=
        eventTimeNow) {
      return await Future.delayed(
          const Duration(seconds: 1),
          () => Duration(
              hours: int.parse(stringConverter(
                  adzanModel.magrib.toString().substring(0, 2))),
              minutes: int.parse(stringConverter(
                  adzanModel.magrib.toString().substring(2, 5)))));
    }
    if (int.parse(stringConverter(adzanModel.magrib.toString())) >=
        eventTimeNow) {
      return await Future.delayed(
          const Duration(seconds: 1),
          () => Duration(
              hours: int.parse(
                  stringConverter(adzanModel.isya.toString().substring(0, 2))),
              minutes: int.parse(stringConverter(
                  adzanModel.isya.toString().substring(2, 5)))));
    }
    if (int.parse(stringConverter(adzanModel.isya.toString())) >=
        eventTimeNow) {
      return await Future.delayed(
          const Duration(seconds: 1),
          () => Duration(
              hours: 05,
              minutes: int.parse(stringConverter(
                  adzanModel.shubuh.toString().substring(2, 5)))));
    }
    return const Duration(hours: 0, minutes: 0);
  }
}
