import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../const/colors.dart';
import '../../domain/entity/calendar_event.dart';
import 'event_card.dart';

class DayEvents extends StatelessWidget {
  const DayEvents({
    Key? key,
    required this.days,
    required this.events,
    required this.mainIndex,
  }) : super(key: key);

  final List<DateTime> days;
  final List<List<CalendarEventEntity>> events;
  final int mainIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 17.sp,
                  backgroundColor: MyColors().dayEdgeColor,
                  child: CircleAvatar(
                    backgroundColor: MyColors().tabBarColor,
                    radius: 15.sp,
                    child: Text(
                      days[mainIndex].day.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 13,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: events[mainIndex].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: EventCard(
                        calendarEventEntity: events[mainIndex][index]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
