part of 'calender_bloc.dart';

abstract class CalenderEvent extends Equatable {
  const CalenderEvent();
}

class GetAllEvents extends CalenderEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreateEvent extends CalenderEvent {
  final CalendarEventEntity calendarEvent;

  CreateEvent(this.calendarEvent);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateEvent extends CalenderEvent {
  final CalendarEventEntity calendarEvent;

  UpdateEvent(this.calendarEvent);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteEvent extends CalenderEvent {
  final int id;

  DeleteEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetEvent extends CalenderEvent {
  final int id;

  GetEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
