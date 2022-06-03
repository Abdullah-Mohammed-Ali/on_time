import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';
import 'package:on_time/features/home_screen/schedule_module/presentaion/calender_bloc/calender_bloc.dart';
import 'package:on_time/features/home_screen/schedule_module/presentaion/widgets/styles_calendar/calendar_style.dart';
import 'package:on_time/features/home_screen/schedule_module/presentaion/widgets/styles_calendar/header_style.dart';
import 'package:table_calendar/table_calendar.dart';

import '/dependency_container.dart' as di;
import '../../../../../const/colors.dart';
import '../../../../../const/functions.dart';
import '../widgets/days_event.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime focusedDayz = DateTime.now();
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<CalenderBloc>()..add(GetAllEvents()),
        ),
      ],
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<CalenderBloc, CalenderState>(
            builder: (context, state) {
              var bloc = CalenderBloc.get(context);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TableCalendar<CalendarEventEntity>(
                    eventLoader: (dateTime) {
                      return bloc.groups[
                              formatter.parse(formatter.format(dateTime))] ??
                          [];
                    },
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      weekendStyle: TextStyle(
                          color: MyColors().holidayCalendarColor,
                          fontWeight: FontWeight.w500),
                    ),
                    startingDayOfWeek: StartingDayOfWeek.saturday,
                    headerStyle: myHeaderStyle(),
                    pageJumpingEnabled: true,
                    weekendDays: const [DateTime.friday],
                    calendarStyle: MyCalendarStyle(),
                    focusedDay: focusedDayz,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    selectedDayPredicate: (selectedDay) {
                      return isSameDay(focusedDayz, selectedDay);
                    },
                    onPageChanged: (focusedDay) {
                      focusedDayz = focusedDay;
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      this.selectedDay = selectedDay;

                      setState(() {
                        focusedDayz = selectedDay;
                        focusedDayz = focusedDay;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       print(scheduleEvents[selectedDay]);
                  //       if (scheduleEvents[selectedDay] != null) {
                  //         print('test');
                  //         // scheduleEvents[selectedDay]!.add(
                  //         //   CalendarEventEntity('title', 'content', '25/5/2022',
                  //         //       '25/5/2022', '25/5/2022', 1, 1, 1,
                  //         //       id: 1),
                  //         // );
                  //
                  //       } else {
                  //         scheduleEvents[selectedDay!] = [];
                  //         // scheduleEvents[selectedDay]!.add(
                  //         //   CalendarEventEntity('title', 'content', '25/5/2022',
                  //         //       '25/5/2022', '25/5/2022', 1, 1, 1,
                  //         //       id: 1),
                  //         // );
                  //       }
                  //     },
                  //     child: Text(Inheritance.of(context).name)),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Schedule',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                              )),
                          Expanded(
                            flex: 7,
                            child: myList(state),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget myList(CalenderState state) {
  if (state is GetAllEventsSuccess) {
    DateTime day = (DateTime.parse(formatter.format(DateTime.now())));
    List<DateTime> days = state.events.keys.toList();
    List<List<CalendarEventEntity>> events = state.events.values.toList();

    if (state.events.isNotEmpty) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.events.length,
          itemBuilder: (context, mainIndex) {
            return DayEvents(days: days, events: events, mainIndex: mainIndex);
          });
    } else {
      return Container();
    }
  } else {
    return Container();
  }
}
