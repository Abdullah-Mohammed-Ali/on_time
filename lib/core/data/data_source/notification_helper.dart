import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tzz;

import '../../../features/home_screen/schedule_module/domain/entity/calendar_event.dart';

class NotificationHelper {
  final notification = FlutterLocalNotificationsPlugin();
  NotificationHelper(notification);
  Future initNotifications() async {
    tz.initializeTimeZones();

    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ios);
    await notification.initialize(
      settings,
    );
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'event id',
        'event notification',
        importance: Importance.max,
        priority: Priority.max,
      ),
    );
  }

  Future notify({
    required int id,
    required title,
    required body,
    required DateTime date,
    required TimeOfDay time,
  }) async {
    DateTime combine =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    tzz.TZDateTime dates;
    if (combine.isBefore(DateTime.now())) {
      dates =
          tzz.TZDateTime.from(combine, tzz.local).add(const Duration(days: 1));
    } else {
      dates = tzz.TZDateTime.from(combine, tzz.local);
    }
    await notification.zonedSchedule(
        id, title, body, dates, notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
  }

  Future notifyInstance({
    required CalendarEventEntity calendarEventEntity,
  }) async {
    await notification.show(1, calendarEventEntity.title,
        calendarEventEntity.content, notificationDetails());
  }
}
