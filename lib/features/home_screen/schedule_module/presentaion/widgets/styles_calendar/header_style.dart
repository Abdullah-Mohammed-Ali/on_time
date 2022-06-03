import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

HeaderStyle myHeaderStyle() {
  return HeaderStyle(
      titleTextStyle: const TextStyle(color: Colors.white),
      formatButtonVisible: false,
      leftChevronVisible: false,
      rightChevronVisible: false,
      headerPadding: EdgeInsets.symmetric(vertical: 15.h),
      titleCentered: true);
}
