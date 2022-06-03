import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:on_time/const/functions.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';

import '../../features/home_screen/schedule_module/domain/entity/calendar_event.dart';
import '../data/data_source/notification_helper.dart';

class ScheduledNotificationUseCase
    implements UseCases<Unit, NotificationParams> {
  final NotificationHelper _notification;

  ScheduledNotificationUseCase(this._notification);
  @override
  Future<Either<Failure, Unit>?> call(params) async {
    TimeOfDay time = TimeOfDay.fromDateTime(
        timeFormatter.parse(params.calendarEventEntity.reminder));
    print(time);
    _notification.notify(
        id: Random().nextInt(10000),
        title: params.calendarEventEntity.title,
        body: params.calendarEventEntity.content,
        date: formatter.parse(params.calendarEventEntity.date),
        time: time);
  }
}

class NotificationParams {
  final CalendarEventEntity calendarEventEntity;

  NotificationParams(
    this.calendarEventEntity,
  );
}
