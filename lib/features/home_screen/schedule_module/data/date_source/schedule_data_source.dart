import 'package:on_time/const/strings.dart';
import 'package:on_time/features/home_screen/schedule_module/data/model/calendar_event_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocaleDateSourceSchedule<Type> {
  // create
  Future<bool?> createData(Type model);
  // read
  Future<Type?> getData(int id);
  // read list
  Future<List<Type>?> getListOfData();
  // update
  Future<bool?> updateData(Type mod);
  // delete
  Future<bool?> deleteData(int id);
}

class ScheduleDataSource
    implements LocaleDateSourceSchedule<CalendarEventModel> {
  final Database myDatabase;

  ScheduleDataSource(this.myDatabase);
  @override
  Future<bool?> createData(model) async {
    await myDatabase.transaction((txn) async {
      await txn.insert(scheduleTable, model.toMap());
    });
  }

  @override
  Future<bool?> deleteData(int id) async {
    await myDatabase.transaction((txn) async {
      await txn
          .delete(scheduleTable, where: '$eventIdColumn = ?', whereArgs: [id]);
    });
  }

  @override
  Future<CalendarEventModel?> getData(int id) async {
    await myDatabase.transaction((txn) async {
      await txn.rawQuery(
          'SELECT * FROM $scheduleTable WHERE $eventIdColumn = ?', [id]).then(
        (value) => CalendarEventModel.fromMap(value.first),
      );
    });
  }

  @override
  Future<List<CalendarEventModel>?> getListOfData() async {
    List<CalendarEventModel> result = [];
    await myDatabase.transaction((txn) async {
      await txn.rawQuery('SELECT * FROM $scheduleTable').then(
        (value) {
          value.forEach((element) {
            result.add(CalendarEventModel.fromMap(element));
          });
        },
      );
    });
    return result;
  }

  @override
  Future<bool?> updateData(CalendarEventModel model) async {
    await myDatabase.transaction((txn) async {
      await txn.update(scheduleTable, model.toMap(),
          where: '$eventIdColumn = ?', whereArgs: [model.id]);
    });
    return true;
  }
}
