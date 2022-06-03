import 'package:on_time/const/strings.dart';
import 'package:on_time/features/home_screen/notes_module/data/models/notes_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocaleDateSource<Type> {
  // create
  Future<bool?> createData(Type model);
  // read
  Future<Type?> getData(int id);
  // read list
  Future<List<Type>?> getListOfData();
  // update
  Future<bool?> updateData(NotesModel notesModel);
  // delete
  Future<bool?> deleteData(int id);

  Future<List<Type>?> searchData(String search);
}

class MyDatabase {
  late Database myDatabase;
  String noteIdColumn = 'id';
  String noteTitleColumn = 'title';
  String noteContentColumn = 'content';
  String noteIsPinnedColumn = 'isPinned';
  String noteDateColumn = 'isPinned';

  Future<Database> inint(int version) async {
    myDatabase = await openDatabase(databasePath, version: version,
        onCreate: (db, version) async {
      await db.execute(
          "Create TABLE $notesTable ($noteIdColumn INTEGER PRIMARY KEY , $noteTitleColumn STRING , $noteContentColumn STRING , $noteIsPinnedColumn INTEGER,$noteDateColumn STRING");
      await db.execute(
          "Create TABLE $scheduleTable (id INTEGER PRIMARY KEY , title STRING , note STRING ,startDate STRING,"
          "endDate STRING,place STRING,isDone INTEGER, isFullDay INTEGER,reminder STRING");
    });
    return myDatabase;
  }
}
