part of 'adzan_time_bloc.dart';

abstract class AdzanTimeEvent extends Equatable {
  const AdzanTimeEvent();

  @override
  List<Object?> get props => [];
}

class InitAdzanTime extends AdzanTimeEvent {
  const InitAdzanTime();

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
  final Duration countingTime;
  final Duration lockDuration;
  final String adzanName;

  const StartAdzan(
      {required this.duration,
      required this.countingTime,
      required this.lockDuration,
      required this.adzanName});

  @override
  List<Object?> get props => [duration, countingTime, lockDuration, adzanName];
}
