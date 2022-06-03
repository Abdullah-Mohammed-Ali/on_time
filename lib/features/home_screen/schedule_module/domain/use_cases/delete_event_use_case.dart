import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/repo/calendar_event_repo.dart';

class DeleteCalendarEventUseCase
    implements UseCases<Unit, DeleteCalendarEventParams> {
  final CalendarEventRepo _calendarEventRepo;

  DeleteCalendarEventUseCase(this._calendarEventRepo);
  @override
  Future<Either<Failure, Unit>?> call(
      DeleteCalendarEventParams deleteCalendarEventParams) async {
    return await _calendarEventRepo
        .deleteCalendarEvent(deleteCalendarEventParams.id);
  }
}

class DeleteCalendarEventParams {
  final int id;

  DeleteCalendarEventParams(this.id);
}
