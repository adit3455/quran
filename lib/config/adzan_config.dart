import 'dart:async';

import '../models/export_models.dart';

class AdzanConfig {
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
