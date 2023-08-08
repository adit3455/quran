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
}
