import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/repo/calendar_event_repo.dart';

class UpdateCalendarEventUseCase
    implements UseCases<bool, UpdateCalendarEventParams> {
  final CalendarEventRepo _calendarEventRepo;

  UpdateCalendarEventUseCase(this._calendarEventRepo);
  @override
  Future<Either<Failure, bool>?> call(
      UpdateCalendarEventParams calendarEventParams) async {
    return await _calendarEventRepo
        .updateCalendarEvent(calendarEventParams.calendarEvent);
  }
}

class UpdateCalendarEventParams {
  final CalendarEventEntity calendarEvent;

  UpdateCalendarEventParams(this.calendarEvent);
}
