import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/repo/calendar_event_repo.dart';

class GetCalendarEventUseCase
    implements UseCases<CalendarEventEntity, GetCalendarEventParams> {
  final CalendarEventRepo _calendarEventRepo;

  GetCalendarEventUseCase(this._calendarEventRepo);
  @override
  Future<Either<Failure, CalendarEventEntity>?> call(
      GetCalendarEventParams getCalendarEventParams) async {
    return await _calendarEventRepo.getCalendarEvent(getCalendarEventParams.id);
  }
}

class GetCalendarEventParams {
  final int id;

  GetCalendarEventParams(this.id);
}
