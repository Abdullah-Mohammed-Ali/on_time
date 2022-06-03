import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/features/home_screen/schedule_module/data/date_source/schedule_data_source.dart';
import 'package:on_time/features/home_screen/schedule_module/data/model/calendar_event_model.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';

import '../../domain/repo/calendar_event_repo.dart';

class CalendarEventRepoImpl implements CalendarEventRepo {
  final ScheduleDataSource _scheduleDataSource;

  CalendarEventRepoImpl(this._scheduleDataSource);
  @override
  Future<Either<Failure, Unit>?> createCalendarEvent(
      CalendarEventEntity calendarEvent) async {
    CalendarEventModel calendarEventModel =
        CalendarEventModel.fromEntity(calendarEvent);
    await _scheduleDataSource.createData(calendarEventModel);
  }

  @override
  Future<Either<Failure, Unit>?> deleteCalendarEvent(int id) async {
    try {
      await _scheduleDataSource.deleteData(id);
    } catch (e) {
      return Left(CalendarFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CalendarEventEntity>>?>
      getAllCalendarEvents() async {
    try {
      final result = await _scheduleDataSource.getListOfData();
      print(result![0].toMap());
      return Right(result);
    } catch (e) {
      return Left(CalendarFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CalendarEventEntity>?> getCalendarEvent(int id) async {
    try {
      final result = await _scheduleDataSource.getData(id);
      return Right(result!);
    } catch (e) {
      return Left(CalendarFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>?> updateCalendarEvent(
      CalendarEventEntity calendarEvent) async {
    CalendarEventModel calendarEventModel =
        CalendarEventModel.fromEntity(calendarEvent);
    print(calendarEvent.id);
    try {
      final result = await _scheduleDataSource.updateData(calendarEventModel);
      return Right(result!);
    } catch (e) {
      return Left(CalendarFailure(e.toString()));
    }
  }
}
