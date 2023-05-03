import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'notification_changer_event.dart';
part 'notification_changer_state.dart';

class NotificationChangerBloc
    extends Bloc<NotificationChangerEvent, NotificationChangerState> {
  NotificationChangerBloc() : super(const NotificationChangerSwitch()) {
    on<NotificationChangerSwitchEvent>((event, emit) async {
      try {
        Box box = await Hive.openBox<bool>('notif_adzan');

        box.put('notif_adzan', event.notification);
        bool getNotif = await box.get('notif_adzan');

        emit(NotificationChangerSwitch(notification: getNotif));
      } catch (e) {
        emit(NotificationChangerError(e.toString()));
      }
    });
  }
}
