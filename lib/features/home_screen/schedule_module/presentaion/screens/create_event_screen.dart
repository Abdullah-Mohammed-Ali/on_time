import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:on_time/const/colors.dart';
import 'package:on_time/features/home_screen/schedule_module/presentaion/calender_bloc/calender_bloc.dart';
import 'package:on_time/features/home_screen/schedule_module/presentaion/widgets/text_form_field_event.dart';
import 'package:on_time/routing.dart';

import '/dependency_container.dart' as di;
import '../../../../../const/functions.dart';
import '../../../../../const/strings.dart';
import '../../../../../core/widgets/my_scaffold.dart';
import '../../domain/entity/calendar_event.dart';
import '../widgets/date_time_picker.dart';
import '../widgets/event_tile.dart';

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({Key? key, this.updatedEvent}) : super(key: key);

  CalendarEventEntity? updatedEvent;

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();
  var placeController = TextEditingController();
  var noteController = TextEditingController();
  var reminderController = TextEditingController();
  bool isRepeated = false;
  bool isFullDay = false;
  bool isDone = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.updatedEvent != null) {
      CalendarEventEntity? entity = widget.updatedEvent;
      // print(entity!.title);

      titleController.text = entity!.title;
      contentController.text = entity.content;
      dateController.text = entity.date;
      placeController.text = entity.place;
      noteController.text = entity.note;
      reminderController.text = entity.reminder;
      isDone = intToBool(entity.isDone);
      isRepeated = intToBool(entity.isRepeat);
      isFullDay = intToBool(entity.isFullDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CalenderBloc>(),
      child: BlocBuilder<CalenderBloc, CalenderState>(
        builder: (context, state) {
          var bloc = CalenderBloc.get(context);
          return MyScaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 8.h),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: isDone
                          ? const Icon(Icons.check_box_outlined)
                          : const Icon(Icons.check_box_outline_blank_sharp),
                      onPressed: () {
                        isDone = !isDone;
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        CalendarEventEntity calendarEvent = CalendarEventEntity(
                            title: titleController.text,
                            content: contentController.text,
                            date: dateController.text,
                            place: placeController.text,
                            note: noteController.text,
                            isDone: boolToIntConverter(isDone),
                            isFullDay: boolToIntConverter(isFullDay),
                            isRepeat: boolToIntConverter(isRepeated),
                            reminder: reminderController.text,
                            id: widget.updatedEvent?.id);

                        if (widget.updatedEvent != null) {
                          print('lets update ${calendarEvent.title}');
                          updatedEvent(bloc, calendarEvent);
                        } else {
                          createEvent(bloc, calendarEvent);
                        }

                        Navigator.pushNamed(context, RoutesName.home);
                      },
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Schedule',
                            style: noteTextStyle(context),
                          ),
                        ),
                        EventTextFormField(
                            contentController: titleController,
                            validatorText: 'validatorText',
                            hintText: 'Title'),
                        const SizedBox(
                          height: 4,
                        ),
                        EventRow(
                          action: Switcher(
                            onTap: (value) {
                              isFullDay = !isFullDay;
                              setState(() {});
                            },
                            value: isFullDay,
                          ),
                          title: 'Full Day',
                        ),
                        EventRow(
                          action: PickDateOrTime(
                            dateController: dateController,
                            onTap: () async {
                              DateFormat formatter = DateFormat('yyyy-MM-dd');
                              await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050))
                                  .then((value) {
                                dateController.text =
                                    formatter.format(value!).trim();
                              });
                            },
                          ),
                          title: 'Date',
                        ),
                        EventRow(
                          action: PickDateOrTime(
                            dateController: reminderController,
                            onTap: () async {
                              await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: DateTime.now().hour,
                                          minute: DateTime.now().minute))
                                  .then((value) => reminderController.text =
                                      value!.format(context));
                            },
                          ),
                          title: 'Reminder',
                        ),
                        EventRow(
                          action: Switcher(
                            onTap: (bool value) {
                              isRepeated = !isRepeated;
                              setState(() {});
                            },
                            value: isRepeated,
                          ),
                          title: 'Repeat',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: EventTextFormField(
                              contentController: placeController,
                              validatorText: 'validatorText',
                              hintText: 'Place'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: EventTextFormField(
                              contentController: noteController,
                              validatorText: 'validatorText',
                              hintText: 'Note'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void createEvent(bloc, calendarEvent) {
    bloc.add(CreateEvent(calendarEvent));
  }

  void updatedEvent(bloc, calendarEvent) {
    bloc.add(UpdateEvent(calendarEvent));
  }
}

class Switcher extends StatelessWidget {
  final Function(bool value) onTap;
  final bool value;
  const Switcher({
    Key? key,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Switch(
        thumbColor: MaterialStateProperty.all(MyColors().switchColor),
        trackColor: value
            ? MaterialStateProperty.all(MyColors().searchFillGroundColor)
            : MaterialStateProperty.all(MyColors().tabBarColor),
        value: value,
        onChanged: onTap,
      ),
    );
  }
}
