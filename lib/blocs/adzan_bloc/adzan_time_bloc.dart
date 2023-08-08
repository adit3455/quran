import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_app/config/adzan_config.dart';
import 'package:quran_app/repositories/export_repo.dart';
import 'package:quran_app/services/notification_service.dart';
part 'adzan_time_event.dart';
part 'adzan_time_state.dart';

class AdzanTimeBloc extends Bloc<AdzanTimeEvent, AdzanTimeState> {
  final QuranSurah _quranSurah;
  final AdzanConfig _adzanConfig;
  final NotificationService _notificationService;

  Timer? timer;
  final reduceSecondsBy = 1;
  Duration duration = const Duration();
  Duration countingTime = const Duration();

  AdzanTimeBloc(
      {required QuranSurah quranSurah,
      required AdzanConfig adzanConfig,
      required NotificationService notificationService})
      : _quranSurah = quranSurah,
        _adzanConfig = adzanConfig,
        _notificationService = notificationService,
        super(AdzanTimeLoading()) {
    on<InitAdzanTime>((event, emit) async {
      await _notificationService.initNotification();
      add(const GetAdzanTime());
    });
    on<GetAdzanTime>((event, emit) async {
      DateTime now = DateTime.now();
      emit(AdzanTimeLoading());
      await Future.delayed(const Duration(seconds: 1));

      final adzanDateTime =
          await _adzanConfig.adzanDateTime(_quranSurah.getWaktuAdzan(), now);
      final dateTimeBackwardValue =
          _adzanConfig.dateTimeBackwardValue(adzanDateTime, now);
      final nameAdzanValue = _adzanConfig.nameAdzanValue(adzanDateTime, now);
      final lockDuration = _adzanConfig.getLockDuration(adzanDateTime, now);

      duration = dateTimeBackwardValue;
      countingTime = _adzanConfig.dateNowDurationType(now);
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final countingTimeSeconds = countingTime.inSeconds + 1;
        countingTime = Duration(seconds: countingTimeSeconds);

        final seconds = duration.inSeconds - reduceSecondsBy;
        duration = Duration(seconds: seconds);
        add(StartAdzan(
            duration: duration,
            countingTime: countingTime,
            lockDuration: lockDuration,
            adzanName: nameAdzanValue));
      });
    });

    on<StartAdzan>((event, emit) async {
      emit(AdzanTimeStarted(
          event.duration, event.adzanName, event.lockDuration));
      if (event.duration.inSeconds == 0) {
        _notificationService.showNotification(
            title: "Adzan Notification",
            body: "Waktunya Sholat ${event.adzanName}");
      }
      if (event.duration.inSeconds == -2 ||
          countingTime == _adzanConfig.lateTimeHours) {
        timer?.cancel();
        add(const GetAdzanTime());
      }
    });
  }
}
