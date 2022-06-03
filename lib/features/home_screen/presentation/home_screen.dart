import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_time/const/colors.dart';
import 'package:on_time/core/widgets/inhertance.dart';
import 'package:on_time/features/home_screen/notes_module/presentation/bloc/notes_bloc.dart';
import 'package:on_time/features/home_screen/notes_module/presentation/notes_screen.dart';
import 'package:on_time/features/home_screen/schedule_module/presentaion/screens/schedule_screen.dart';
import 'package:on_time/routing.dart';

import '/dependency_container.dart' as di;
import '../../../core/widgets/my_scaffold.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isNote = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (context) => di.sl<NotesBloc>(),
      child: Inheritance(
        score: 10,
        name: 'my ',
        child: MyScaffold(
          myFloatingButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.menu);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              children: [
                Container(
                  child: Row(children: [
                    Text(
                      'on-time',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Row()
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  color: MyColors().tabBarColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            color: isNote
                                ? MyColors().tabBarColor
                                : MyColors().tabBarEnabledColor,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isNote = !isNote;
                                  });
                                },
                                child: const Text(
                                  'Schedule',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: !isNote
                                ? MyColors().tabBarColor
                                : MyColors().tabBarEnabledColor,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isNote = true;
                                  });
                                },
                                child: const Text(
                                  'Notes',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                noteOrSchedule(isNote),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noteOrSchedule(bool isNote) {
    if (isNote) {
      return const Expanded(child: NotesScreen());
    } else {
      return Expanded(child: ScheduleScreen());
    }
  }
}
