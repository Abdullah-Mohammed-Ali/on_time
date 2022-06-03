import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:on_time/core/data/data_source/notification_helper.dart';
import 'package:on_time/core/use_cases/instance_notification_use_case.dart';
import 'package:on_time/core/use_cases/notification_use_cases.dart';
import 'package:on_time/features/home_screen/notes_module/data/data_source/notes_data_source.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/create_note_use_case.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/get_note_use_case.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/get_notes_use_case.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/search_note_use_case.dart';
import 'package:on_time/features/home_screen/notes_module/presentation/bloc/notes_bloc.dart';
import 'package:on_time/features/home_screen/schedule_module/data/repo/event_calendar_repo_imp.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/repo/calendar_event_repo.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/use_cases/create_event_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/use_cases/delete_event_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/use_cases/get_all_events_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/use_cases/get_event_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/domain/use_cases/update_event_use_case.dart';
import 'package:on_time/features/home_screen/schedule_module/presentaion/calender_bloc/calender_bloc.dart';
import 'package:on_time/features/splash_getting_started/data/repo/cashed_repo_imp.dart';
import 'package:on_time/features/splash_getting_started/domain/use_cases/save_cashe_use_case.dart';
import 'package:on_time/features/splash_getting_started/presentation/cashed_bloc/cashed_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'const/strings.dart';
import 'features/home_screen/notes_module/data/repo/note_repo_imp.dart';
import 'features/home_screen/notes_module/domain/repos/notes_repo.dart';
import 'features/home_screen/notes_module/domain/use_cases/delete_note_use_case.dart';
import 'features/home_screen/notes_module/domain/use_cases/update_note_use_case.dart';
import 'features/home_screen/schedule_module/data/date_source/schedule_data_source.dart';
import 'features/splash_getting_started/data/data_source/data_source.dart';
import 'features/splash_getting_started/domain/repo/cashe_repo.dart';
import 'features/splash_getting_started/domain/use_cases/cashe_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features...
  /// notes ...
  //bloc
  sl.registerFactory(() => NotesBloc(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));

  //use cases
  sl.registerLazySingleton(() => CreateNoteUseCase(sl()));
  sl.registerLazySingleton(() => GetNoteUseCase(sl()));
  sl.registerLazySingleton(() => GetNotesUseCase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUseCase(sl()));
  sl.registerLazySingleton(() => UpdateNoteUseCase(sl()));
  sl.registerLazySingleton(() => SearchNoteUseCase(sl()));

  //repo
  sl.registerLazySingleton<NotesRepo>(() => NotesRepoImp(sl()));

  //data source
  sl.registerLazySingleton<NotesDataSource>(() => NotesDataSourceImpl(sl()));

  // database
  Database myDataBase = await openDatabase(databasePath, version: 1,
      onCreate: (db, version) async {
    await db.execute(

        // CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)
        "Create TABLE $notesTable ($noteIdColumn INTEGER PRIMARY KEY , $noteTitleColumn TEXT , $noteContentColumn TEXT , $noteIsPinnedColumn INTEGER,$noteDateColumn TEXT)");
    await db.execute(
        "Create TABLE $scheduleTable ($eventIdColumn INTEGER PRIMARY KEY , $eventTitleColumn STRING , $eventContentColumn STRING,$eventNoteColumn STRING ,$eventDateColumn STRING,"
        "$eventPlaceColumn STRING,$eventIsDoneColumn INTEGER, $eventIsFullDayColumn INTEGER, $eventIsRepeatedColumn INTEGER, $eventReminderColumn STRING)");
  }, onOpen: (db) {});
  sl.registerLazySingleton<Database>(() => myDataBase);

  // events...
  // Bloc

  sl.registerFactory(() => CalenderBloc(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  // use cases
  sl.registerLazySingleton(() => CreateCalendarEventUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCalendarEventUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCalendarEventUseCase(sl()));
  sl.registerLazySingleton(() => GetCalendarEventUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCalendarEventUseCase(sl()));

  // repo

  sl.registerLazySingleton<CalendarEventRepo>(
      () => CalendarEventRepoImpl(sl()));
  //data source
  sl.registerLazySingleton<ScheduleDataSource>(() => ScheduleDataSource(sl()));

  // data

  // out source
  // Bloc ..
  sl.registerFactory(() => CashedBloc(sl(), sl()));

// use cases
  sl.registerLazySingleton(() => SaveCasheUseCase(sl()));
  sl.registerLazySingleton(() => GetCasheUseCase(sl()));
  // repo implementation...
  sl.registerLazySingleton<CasheRepo>(() => CashedRepoImpl(sl()));
  // data Source
  sl.registerLazySingleton<CashedDataSource>(() => CashedDataSource(sl()));

  // Shared preferences

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // local Notification...
  sl.registerLazySingleton(() => InstanceNotificationUseCase(sl()));

  sl.registerLazySingleton(() => ScheduledNotificationUseCase(sl()));
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final notification = NotificationHelper(notificationsPlugin);
  await notification.initNotifications();

  sl.registerLazySingleton<NotificationHelper>(() => notification);
}
