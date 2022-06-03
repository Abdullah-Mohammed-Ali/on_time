import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/get_notes_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/repo/calendar_event_repo.dart';

class GetAllCalendarEventUseCase
    implements UseCases<List<CalendarEventEntity>, NoParam> {
  final CalendarEventRepo _calendarEventRepo;

  GetAllCalendarEventUseCase(this._calendarEventRepo);
  @override
  Future<Either<Failure, List<CalendarEventEntity>>?> call(
      NoParam noParam) async {
    return await _calendarEventRepo.getAllCalendarEvents();
  }
}
