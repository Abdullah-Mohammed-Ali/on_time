class CalendarEventEntity {
  int? id;
  final String title;
  final String content;
  final String date;
  final String place;
  final String note;
  final int isRepeat;
  final int isFullDay;
  final int isDone;
  final String reminder;

  CalendarEventEntity(
      {required this.title,
      required this.content,
      required this.date,
      required this.place,
      required this.note,
      required this.isRepeat,
      required this.isFullDay,
      required this.isDone,
      required this.reminder,
      this.id});
}
