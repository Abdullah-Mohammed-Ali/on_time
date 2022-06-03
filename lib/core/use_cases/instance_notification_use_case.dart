import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';

import '../data/data_source/notification_helper.dart';

class InstanceNotificationUseCase
    implements UseCases<Unit, CalendarEventEntity> {
  final NotificationHelper _notification;

  InstanceNotificationUseCase(this._notification);
  @override
  Future<Either<Failure, Unit>?> call(calendarevent) async {
    _notification.notifyInstance(
      calendarEventEntity: calendarevent,
    );
  }
}
