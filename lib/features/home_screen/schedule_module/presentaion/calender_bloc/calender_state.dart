part of 'calender_bloc.dart';

abstract class CalenderState extends Equatable {
  const CalenderState();
}

class CalenderInitial extends CalenderState {
  @override
  List<Object> get props => [];
}

// creating event
class CreateEventLoading extends CalenderState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreateEventSuccess extends CalenderState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// getting event
class GetEventLoading extends CalenderState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetEventSuccess extends CalenderState {
  final CalendarEventEntity event;

  GetEventSuccess(this.event);
  @override
  // TODO: implement props
  List<Object?> get props => [event];
}

// getting all events...
class GetAllEventLoading extends CalenderState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetAllEventsSuccess extends CalenderState {
  final Map<DateTime, List<CalendarEventEntity>> events;

  const GetAllEventsSuccess(this.events);
  @override
  // TODO: implement props
  List<Object?> get props => [events];
}

// updating event...
class UpdateEventLoading extends CalenderState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateEventSuccess extends CalenderState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateEventError extends CalenderState {
  final String error;

  UpdateEventError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

// deleting event...
class DeleteEventLoading extends CalenderState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteEventSuccess extends CalenderState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
