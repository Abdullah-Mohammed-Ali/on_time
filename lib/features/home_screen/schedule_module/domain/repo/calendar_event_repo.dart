import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entity/calendar_event.dart';

abstract class CalendarEventRepo {
  Future<Either<Failure, Unit>?> createCalendarEvent(
      CalendarEventEntity calendarEvent);
  Future<Either<Failure, CalendarEventEntity>?> getCalendarEvent(int id);
  Future<Either<Failure, List<CalendarEventEntity>>?> getAllCalendarEvents();
  Future<Either<Failure, Unit>?> deleteCalendarEvent(int id);
  Future<Either<Failure, bool>?> updateCalendarEvent(
      CalendarEventEntity calendarEvent);
}
