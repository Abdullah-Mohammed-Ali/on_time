import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/presentation/notes_screen.dart';
import 'package:on_time/features/home_screen/presentation/home_screen.dart';
import 'package:on_time/features/home_screen/presentation/menu_screen.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/entity/calendar_event.dart';
import 'package:on_time/features/home_screen/schedule_module/presentaion/screens/schedule_screen.dart';
import 'package:on_time/features/splash_getting_started/presentation/cashed_bloc/cashed_bloc.dart';
import 'package:on_time/features/splash_getting_started/presentation/screen/start_up.dart';

import '/dependency_container.dart' as di;
import 'features/home_screen/notes_module/presentation/create_notes_screen.dart';
import 'features/home_screen/schedule_module/presentaion/screens/create_event_screen.dart';
import 'features/splash_getting_started/presentation/screen/splashScreen.dart';

class MyRoutes {
  final CashedBloc cashedBloc = di.sl<CashedBloc>();
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.splash:
        return fadeInPageBuilder(
            BlocProvider<CashedBloc>(
              create: (context) => cashedBloc..add(GetDataEvent('first time')),
              child: SplashScreen(),
            ),
            durationMili: 500);
      case RoutesName.startup:
        return fadeInPageBuilder(
            BlocProvider<CashedBloc>(
              create: (context) => cashedBloc,
              child: const StartUpScreen(),
            ),
            durationMili: 500);
      case RoutesName.createNote:
        NoteEntity? args = routeSettings.arguments as NoteEntity?;
        return fadeInPageBuilder(
            CreateNoteScreen(
              editedNote: args,
            ),
            durationMili: 500);
      case RoutesName.home:
        return fadeInPageBuilder(HomeScreen());
      case RoutesName.menu:
        return fadeInPageBuilder(const MenuScreen(), durationMili: 500);
      case RoutesName.notesScreen:
        return fadeInPageBuilder(const NotesScreen(), durationMili: 500);
      case RoutesName.eventsScreen:
        var calendarEvent = routeSettings.arguments as CalendarEventEntity?;
        return fadeInPageBuilder(
            CreateEventScreen(
              updatedEvent: calendarEvent,
            ),
            durationMili: 500);
      case RoutesName.calendarScreen:
        return fadeInPageBuilder(ScheduleScreen(), durationMili: 500);
    }
  }

  PageRouteBuilder fadeInPageBuilder(
    page, {
    durationMili = 750,
  }) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            page,
        transitionsBuilder: (_, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: durationMili));
  }
}

class RoutesName {
  static const splash = '/splashScreen';
  static const startup = '/startupScreen';
  static const home = '/homeScreen';
  static const menu = '/menuScreen';
  static const createNote = '/CreateNoteScreen';
  static const notesScreen = '/notesScreen';
  static const eventsScreen = '/eventsScreen';
  static const calendarScreen = '/calendarScreen';
}
