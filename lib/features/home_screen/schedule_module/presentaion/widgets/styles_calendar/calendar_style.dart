import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../const/colors.dart';

CalendarStyle MyCalendarStyle() {
  return CalendarStyle(
    defaultTextStyle:
        const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    todayTextStyle:
        const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w500),
    todayDecoration: const BoxDecoration(),
    weekendTextStyle: TextStyle(
        color: MyColors().holidayCalendarColor, fontWeight: FontWeight.w500),
  );
}
