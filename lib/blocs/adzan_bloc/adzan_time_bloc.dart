import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_app/config/adzan_config.dart';
import 'package:quran_app/repositories/export_repo.dart';
import 'package:quran_app/services/notification_service.dart';
import '../../models/export_models.dart';
import '../../utils/export_utils.dart';
part 'adzan_time_event.dart';
part 'adzan_time_state.dart';

class AdzanTimeBloc extends Bloc<AdzanTimeEvent, AdzanTimeState> {
  final QuranSurah _quranSurah;
  final AdzanConfig _adzanConfig;
  final NotificationService _notificationService;

  AdzanTimeBloc(this._quranSurah, this._adzanConfig, this._notificationService)
      : super(AdzanTimeLoading()) {
    on<GetAdzanTime>((event, emit) async {
      String timeNowBloc = DateFormat('kk:mm', 'id_ID').format(DateTime.now());
      String timeAdzanBloc = DateFormat('y-MM-dd').format(DateTime.now());
      final timeNowWithoutSymbol = timeNowBloc.replaceAll(':', '');
      final timeNowparsing = int.parse(timeNowWithoutSymbol);

      _notificationService.initNotification();
      List<AdzanModel> adzanTime = await _quranSurah.getWaktuAdzan();

      final getTimeAdzanTanggalFirst =
          adzanTime.firstWhere((element) => element.tanggal == timeAdzanBloc);

      Duration durationAdzan = _adzanConfig.getDurationAdzan(
          getTimeAdzanTanggalFirst, timeNowparsing);

      String adzanTimeName = _adzanConfig.getTimeNameAdzan(
          getTimeAdzanTanggalFirst, timeNowparsing);

      final changeTimeNameAdzan = _adzanConfig.changeTimeNameAdzan(
          getTimeAdzanTanggalFirst, timeNowparsing);

      Duration durationParseSubString =
          Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute);

      Duration timeNow =
          durationAdzan.inSeconds - durationParseSubString.inSeconds <= 0
              ? durationParseSubString - durationAdzan
              : durationAdzan - durationParseSubString;

      final adzanTimeLock = adzanTimeName == 'Shubuh'
          ? Duration(
              hours: int.parse(
                  getTimeAdzanTanggalFirst.shubuh.toString().substring(0, 2)),
              minutes: int.parse(
                  getTimeAdzanTanggalFirst.shubuh.toString().substring(3, 5)))
          : durationAdzan;

      Duration? changeTimeAdzan = await _adzanConfig.changeTimeAdzan(
          getTimeAdzanTanggalFirst, timeNowparsing);

      Duration changeTimeNow = changeTimeAdzan! - durationParseSubString;

      Timer.periodic(const Duration(seconds: 1), (timer) {
        const Duration duration = Duration(seconds: 0, hours: 0, minutes: 0);

        const reduceSecondsBy = 1;
        final seconds = timeNow.inSeconds - reduceSecondsBy;
        final changingSeconds = changeTimeNow.inSeconds - reduceSecondsBy;

        timeNow = Duration(seconds: seconds);

        changeTimeNow = Duration(seconds: changingSeconds);

        add(NotificationAdzan(duration: timeNow, adzanName: adzanTimeName));

        if (timeNow.inSeconds >= 0) {
          add(StartAdzan(
              duration: timeNow,
              adzanName: adzanTimeName,
              adzanTimeLock: adzanTimeLock,
              notification: state is AdzanTimeLoading
                  ? false
                  : (state as AdzanTimeStarted).notification));
        }
        if (timeNow == duration && timeNow <= duration) {
          add(ChangingTimeAdzan(
              duration: changeTimeNow,
              adzanName: changeTimeNameAdzan,
              timeNow: changeTimeAdzan));
        }
      });
    });

    on<StartAdzan>((event, emit) async {
      emit(AdzanTimeStarted(
          event.duration, event.adzanName, event.adzanTimeLock,
          notification: event.notification));
    });

    on<NotificationAdzan>((event, emit) {
      const Duration duration = Duration(seconds: 0, hours: 0, minutes: 0);

      if (event.duration == duration) {
        _notificationService.showNotification(
            body: 'Waktunya Sholat ${event.adzanName}',
            title: 'Waktunya Adzan');
      }
    });

    on<ChangingTimeAdzan>((event, emit) async {
      emit(AdzanTimeChanged(
          event.duration!, event.adzanName!.toString(), event.timeNow!));
    });
  }
}
