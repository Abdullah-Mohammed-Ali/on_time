import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_time/const/functions.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/instance_notification_use_case.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/get_notes_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/use_cases/delete_event_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/use_cases/get_all_events_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/use_cases/get_event_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/use_cases/update_event_use_case.dart';

import '../../../../../core/use_cases/notification_use_cases.dart';
import '../../domain/use_cases/create_event_use_case.dart';

part 'calender_event.dart';
part 'calender_state.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  final CreateCalendarEventUseCase _calendarEventUseCase;
  final GetAllCalendarEventUseCase _getAllCalendarEventUseCase;
  final GetCalendarEventUseCase _getCalendarEventUseCase;
  final UpdateCalendarEventUseCase _updateCalendarEventUseCase;
  final DeleteCalendarEventUseCase _deleteCalendarEventUseCase;
  final InstanceNotificationUseCase _notificationUseCase;
  final ScheduledNotificationUseCase _notificationScheduledUseCase;

  static CalenderBloc get(context) => BlocProvider.of(context);
  CalenderBloc(
      this._calendarEventUseCase,
      this._getAllCalendarEventUseCase,
      this._getCalendarEventUseCase,
      this._updateCalendarEventUseCase,
      this._deleteCalendarEventUseCase,
      this._notificationUseCase,
      this._notificationScheduledUseCase)
      : super(CalenderInitial()) {
    on<CalenderEvent>((event, emit) async {
      if (event is CreateEvent) {
        emit(CreateEventLoading());
        CreateCalendarEventParams _calendarEventParameters =
            CreateCalendarEventParams(event.calendarEvent);
        var result = await _calendarEventUseCase.call(_calendarEventParameters);
        result?.fold(
          (l) => CreateFailure('errorMessage'),
          (r) {
            return emit(
              CreateEventSuccess(),
            );
          },
        );
        NotificationParams params = NotificationParams(event.calendarEvent);
        if (event.calendarEvent.reminder != '') {
          _notificationScheduledUseCase.call(params);
        }
      }
      if (event is GetAllEvents) {
        await getaAll();
      }
      if (event is GetEvent) {
        emit(GetEventLoading());
        GetCalendarEventParams _params = GetCalendarEventParams(event.id);
        final result = await _getCalendarEventUseCase.call(_params);
        result?.fold((l) => CreateFailure('errorMessage'), (r) {
          emit(
            GetEventSuccess(r),
          );
        });
      }
      if (event is DeleteEvent) {
        await deleteEventFun(event);
        await getaAll();
      }
      if (event is UpdateEvent) {
        emit(UpdateEventLoading());
        UpdateCalendarEventParams _params =
            UpdateCalendarEventParams(event.calendarEvent);
        print(_params.calendarEvent.id);

        Either<Failure, bool>? result =
            await _updateCalendarEventUseCase.call(_params);

        result?.fold(
          (l) {
            CreateFailure('errorMessage');

            return emit(UpdateEventError(l.errorMessage));
          },
          (r) async {
            emit(
              UpdateEventSuccess(),
            );
            await getaAll();
          },
        );
      }
    });
  }
  Map<DateTime, List<CalendarEventEntity>> groups = {};

  Future getaAll() async {
    final result = await _getAllCalendarEventUseCase.call(NoParam());
    result?.fold((l) {
      CreateFailure('errorMessage');
    }, (r) {
      groups = groupBy(r, (CalendarEventEntity p0) {
        return formatter.parse(p0.date);
      });
      emit(GetAllEventsSuccess(groups));
    });
  }

  Future deleteEventFun(event) async {
    emit(DeleteEventLoading());
    DeleteCalendarEventParams _params = DeleteCalendarEventParams(event.id);
    var result = await _deleteCalendarEventUseCase.call(_params);
    result?.fold(
      (l) => CreateFailure('errorMessage'),
      (r) => emit(
        DeleteEventSuccess(),
      ),
    );
  }
}
