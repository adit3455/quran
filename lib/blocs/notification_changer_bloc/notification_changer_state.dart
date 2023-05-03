part of 'notification_changer_bloc.dart';

abstract class NotificationChangerState extends Equatable {
  const NotificationChangerState();

  @override
  List<Object> get props => [];
}

class NotificationChangerSwitch extends NotificationChangerState {
  final bool notification;

  const NotificationChangerSwitch({this.notification = true});

  @override
  List<Object> get props => [notification];
}

class NotificationChangerLoading extends NotificationChangerState {
  @override
  List<Object> get props => [];
}

class NotificationChangerError extends NotificationChangerState {
  final String error;

  const NotificationChangerError(this.error);

  @override
  List<Object> get props => [error];
}
