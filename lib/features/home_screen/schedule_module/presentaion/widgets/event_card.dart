import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_time/const/colors.dart';
import 'package:on_time/features/home_screen/schedule_module/presentaion/calender_bloc/calender_bloc.dart';
import 'package:on_time/routing.dart';

import '../../../../../const/functions.dart';
import '../../../../../const/strings.dart';
import '../../domain/entity/calendar_event.dart';

class EventCard extends StatefulWidget {
  final CalendarEventEntity calendarEventEntity;
  EventCard({
    Key? key,
    required this.calendarEventEntity,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late Offset tapDownDetails;
  @override
  Widget build(BuildContext context) {
    bool isActive = intToBool(widget.calendarEventEntity.isDone);

    return BlocBuilder<CalenderBloc, CalenderState>(
      builder: (context, state) {
        var bloc = CalenderBloc.get(context);

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RoutesName.eventsScreen,
                arguments: widget.calendarEventEntity);
          },
          onLongPress: () {
            showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                    tapDownDetails.dx, tapDownDetails.dy, 0, 0),
                items: [
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            bloc.add(
                                DeleteEvent(widget.calendarEventEntity.id!));
                            Navigator.pop(context);
                          },
                          child: Text('Delete')))
                ]);
          },
          onTapDown: (details) {
            tapDownDetails = details.globalPosition;
          },
          child: Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            color: isActive
                ? MyColors().doneEventColor
                : MyColors().notDoneEventColor,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.calendarEventEntity.title,
                        style: eventTextStyle(context,
                            fontSize: 14, isDone: isActive),
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      Expanded(
                        child: Container(
                          height: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 20,
                            onPressed: () {
                              print('is Done ' +
                                  widget.calendarEventEntity.isDone.toString());
                              CalendarEventEntity modified =
                                  CalendarEventEntity(
                                      title: widget.calendarEventEntity.title,
                                      content:
                                          widget.calendarEventEntity.content,
                                      date: widget.calendarEventEntity.date,
                                      place: widget.calendarEventEntity.place,
                                      note: widget.calendarEventEntity.note,
                                      isRepeat:
                                          widget.calendarEventEntity.isRepeat,
                                      isFullDay:
                                          widget.calendarEventEntity.isFullDay,
                                      id: widget.calendarEventEntity.id,
                                      isDone: boolToIntConverter(!intToBool(
                                          widget.calendarEventEntity.isDone)),
                                      reminder:
                                          widget.calendarEventEntity.reminder);
                              bloc.add(UpdateEvent(modified));
                            },
                            icon: Icon(
                                intToBool(widget.calendarEventEntity.isDone)
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      EventColumnData(
                        titles: const ['Time', 'Place', 'Note'],
                        isDone: isActive,
                      ),
                      Spacer(),
                      Expanded(
                        flex: 9,
                        child: EventColumnData(
                          titles: [
                            widget.calendarEventEntity.date,
                            widget.calendarEventEntity.place,
                            widget.calendarEventEntity.note,
                          ],
                          isTitle: false,
                          isDone: isActive,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EventColumnData extends StatelessWidget {
  final List<String> titles;
  final bool isTitle;
  final bool isDone;
  const EventColumnData({
    Key? key,
    required this.titles,
    this.isTitle = true,
    required this.isDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: titles
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Text(
                  e,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: isDone ? Colors.grey : Colors.white,
                      fontWeight: isTitle ? FontWeight.bold : null),
                ),
              ))
          .toList(),
    );
  }
}
