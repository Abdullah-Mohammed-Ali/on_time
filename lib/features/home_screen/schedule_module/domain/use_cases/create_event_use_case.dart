import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/repo/calendar_event_repo.dart';

class CreateCalendarEventUseCase
    implements UseCases<Unit, CreateCalendarEventParams> {
  final CalendarEventRepo _calendarEventRepo;

  CreateCalendarEventUseCase(this._calendarEventRepo);
  @override
  Future<Either<Failure, Unit>?> call(
      CreateCalendarEventParams calendarEventParams) async {
    return await _calendarEventRepo
        .createCalendarEvent(calendarEventParams.calendarEvent);
  }
}

class CreateCalendarEventParams {
  final CalendarEventEntity calendarEvent;

  CreateCalendarEventParams(this.calendarEvent);
}
