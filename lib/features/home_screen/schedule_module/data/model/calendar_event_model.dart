import 'package:on_time/const/strings.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';

class CalendarEventModel extends CalendarEventEntity {
  CalendarEventModel(
      {required String title,
      required String content,
      required String date,
      required String place,
      required String note,
      required int isRepeat,
      required int isFullDay,
      required int isDone,
      required String reminder,
      int? id})
      : super(
          title: title,
          content: content,
          date: date,
          note: note,
          place: place,
          isRepeat: isRepeat,
          isFullDay: isFullDay,
          reminder: reminder,
          isDone: isDone,
          id: id,
        );

  factory CalendarEventModel.fromMap(Map<String, dynamic> data) {
    return CalendarEventModel(
      id: data[eventIdColumn],
      title: data[eventTitleColumn],
      place: data[eventPlaceColumn],
      content: data[eventContentColumn],
      date: data[eventDateColumn],
      isFullDay: data[eventIsFullDayColumn],
      note: data[eventNoteColumn],
      isRepeat: data[eventIsRepeatedColumn],
      reminder: data[eventReminderColumn] ?? '',
      isDone: data[eventIsDoneColumn],
    );
  }

  factory CalendarEventModel.fromEntity(CalendarEventEntity calendarEvent) {
    return CalendarEventModel(
      title: calendarEvent.title,
      content: calendarEvent.content,
      date: calendarEvent.date,
      place: calendarEvent.place,
      note: calendarEvent.note,
      isRepeat: calendarEvent.isRepeat,
      isFullDay: calendarEvent.isFullDay,
      isDone: calendarEvent.isDone,
      id: calendarEvent.id,
      reminder: calendarEvent.reminder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      eventTitleColumn: title,
      eventContentColumn: content,
      eventNoteColumn: note,
      eventPlaceColumn: place,
      eventIsRepeatedColumn: isRepeat,
      eventIsDoneColumn: isDone,
      eventIsFullDayColumn: isFullDay,
      eventDateColumn: date,
      eventIdColumn: id,
    };
  }
}
