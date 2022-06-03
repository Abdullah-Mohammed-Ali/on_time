import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_time/const/colors.dart';

const appName = 'on.time';
const slogan = '''Make yourself
more on.time''';

const databasePath = 'database.db';

const notesTable = 'notes';
const scheduleTable = 'schedule';
// notes column ...
String noteIdColumn = 'id';
String noteTitleColumn = 'title';
String noteContentColumn = 'content';
String noteIsPinnedColumn = 'isPinned';
String noteDateColumn = 'date';

// event column ...
String eventIdColumn = 'id';
String eventTitleColumn = 'title';
String eventContentColumn = 'content';
String eventPlaceColumn = 'place';
String eventIsDoneColumn = 'isDone';
String eventIsFullDayColumn = 'isFullDay';
String eventIsRepeatedColumn = 'isRepeated';
String eventReminderColumn = 'reminder';
String eventNoteColumn = 'note';
String eventDateColumn = 'date';

TextStyle noteTextStyle(context, {double fontSize = 20}) =>
    Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w500);

TextStyle eventTextStyle(context, {required isDone, double fontSize = 14}) =>
    Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: isDone ? Colors.grey : Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w500);

TextStyle noteCard(context) =>
    Theme.of(context).textTheme.headlineSmall!.copyWith(
        color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w300);
TextStyle eventCard(context) =>
    Theme.of(context).textTheme.headlineSmall!.copyWith(
        color: MyColors().eventTextColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w300);

TextStyle eventTextStyleRow(context) =>
    Theme.of(context).textTheme.headlineSmall!.copyWith(
        color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w300);
