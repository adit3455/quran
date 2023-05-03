part of 'notification_changer_bloc.dart';

abstract class NotificationChangerEvent extends Equatable {
  const NotificationChangerEvent();

  @override
  List<Object> get props => [];
}

class NotificationChangerInit extends NotificationChangerEvent {}

class NotificationChangerSwitchEvent extends NotificationChangerEvent {
  final bool notification;

  const NotificationChangerSwitchEvent(this.notification);

  @override
  List<Object> get props => [notification];
}
