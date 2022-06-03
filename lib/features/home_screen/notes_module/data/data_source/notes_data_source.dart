import 'package:on_time/const/strings.dart';
import 'package:on_time/core/data/data_source/locale_date_source.dart';
import 'package:on_time/core/errors/exception.dart';
import 'package:on_time/features/home_screen/notes_module/data/models/notes_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class NotesDataSource implements LocaleDateSource<NotesModel> {}

class NotesDataSourceImpl implements NotesDataSource {
  final Database _myDatabase;

  NotesDataSourceImpl(this._myDatabase);
  @override
  Future<bool> createData(NotesModel model) async {
    // TODO: implement createData

    await _myDatabase.transaction((txn) async {
      await txn.insert(notesTable, model.toMap());
    }).then((value) {
      return true;
    }).onError((error, stackTrace) => throw CreateNoteException());
    return false;
  }

  @override
  Future<bool> deleteData(int noteFromId) async {
    try {
      await _myDatabase.transaction((txn) async {
        await txn.delete(notesTable,
            where: "${MyDatabase().noteIdColumn} =? ", whereArgs: [noteFromId]);
        return true;
      });
    } catch (e) {
      throw DeleteNoteException();
    }
    return false;
  }

  @override
  Future<NotesModel?> getData(int noteFromId) async {
    NotesModel model;
    try {
      await _myDatabase.query(notesTable,
          where: "${MyDatabase().noteIdColumn} = ?",
          whereArgs: [noteFromId]).then((value) {
        model = NotesModel.fromMap(value[0]);
        return model;
      });
    } catch (e) {
      print(e.toString());

      throw GetNoteException();
    }
  }

  @override
  Future<List<NotesModel>> getListOfData() async {
    List<NotesModel> result = [];
    try {
      await _myDatabase.transaction((txn) async {
        await txn.rawQuery('SELECT * FROM notes').then((value) {
          value.forEach((e) {
            result.add(
              NotesModel.fromMap(e),
            );
          });
        });
      });
      return result;
    } catch (e) {
      print(e.toString());
      throw GetNotesException();
    }
  }

  @override
  Future<List<NotesModel>> searchData(search) async {
    List<NotesModel> result = [];
    try {
      await _myDatabase.transaction((txn) async {
        await txn
            .rawQuery(
                "SELECT * FROM $notesTable WHERE $noteTitleColumn LIKE'%$search%'")
            .then(
          (value) {
            value.forEach((element) {
              result.add(NotesModel.fromMap(element));
            });
            print(value);
          },
        );
      });
      return result;
    } catch (e) {
      print(e.toString());
      throw GetNotesException();
    }
  }

  @override
  Future<bool?> updateData(NotesModel notesModel) async {
    NotesModel? myResult;
    try {
      await _myDatabase.transaction((txn) async {
        await txn.update(notesTable, notesModel.toMap(),
            where: 'id = ?', whereArgs: [notesModel.id]);
      });
      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

class DataSourceParams {
  final NotesModel createModel;
  final int noteFromId;

  DataSourceParams(this.createModel, this.noteFromId);
}
