part of 'adzan_time_bloc.dart';

abstract class AdzanTimeEvent extends Equatable {
  const AdzanTimeEvent();

  @override
  List<Object?> get props => [];
}

class GetAdzanTime extends AdzanTimeEvent {
  const GetAdzanTime();

  @override
  List<Object> get props => [];
}

class StartAdzan extends AdzanTimeEvent {
  final Duration duration;
  final String adzanName;
  final Duration adzanTimeLock;
  final bool notification;

  const StartAdzan(
      {required this.duration,
      required this.adzanName,
      required this.adzanTimeLock,
      required this.notification});

  @override
  List<Object?> get props => [duration, adzanName, adzanTimeLock, notification];
}

class ChangingTimeAdzan extends AdzanTimeEvent {
  final Duration? duration;
  final String? adzanName;
  final Duration? timeNow;

  const ChangingTimeAdzan({this.duration, this.adzanName, this.timeNow});

  @override
  List<Object?> get props => [duration, adzanName, timeNow];
}

class NotificationAdzan extends AdzanTimeEvent {
  final Duration? duration;
  final String? adzanName;

  const NotificationAdzan({this.duration, this.adzanName});
  @override
  List<Object?> get props => [duration, adzanName];
}
