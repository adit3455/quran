part of 'adzan_time_bloc.dart';

abstract class AdzanTimeState extends Equatable {
  const AdzanTimeState();

  @override
  List<Object> get props => [];
}

class AdzanTimeLoading extends AdzanTimeState {
  @override
  List<Object> get props => [];
}

class AdzanTimeStarted extends AdzanTimeState {
  final Duration adzanTime;
  final String adzanName;
  final Duration adzanTimeLock;
  final bool notification;

  const AdzanTimeStarted(this.adzanTime, this.adzanName, this.adzanTimeLock,
      {this.notification = true});

  @override
  List<Object> get props => [adzanTime, adzanName, adzanTimeLock];
}
