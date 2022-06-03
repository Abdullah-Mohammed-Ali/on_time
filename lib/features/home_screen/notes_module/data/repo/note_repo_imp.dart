import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/features/home_screen/notes_module/data/data_source/notes_data_source.dart';
import 'package:on_time/features/home_screen/notes_module/data/models/notes_model.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';

class NotesRepoImp implements NotesRepo {
  final NotesDataSource _notesSource;

  NotesRepoImp(this._notesSource);
  @override
  Future<Either<Failure, bool>?> createNote(NoteEntity noteEntity) async {
    NotesModel model = NotesModel(
        title: noteEntity.title,
        content: noteEntity.content,
        isPinned: noteEntity.isPinned,
        date: noteEntity.date);

    bool? resultBool = await _notesSource.createData(model);
    if (resultBool!) {
      Right<Failure, bool> result = Right(resultBool);
      return result;
    } else {
      Left<Failure, bool> resultFail = Left(CreateFailure('error'));
      return resultFail;
    }
  }

  @override
  Future<Either<Failure, bool>?> deleteNote(int id) async {
    bool? resultBool = await _notesSource.deleteData(id);

    if (resultBool!) {
      return Right(resultBool);
    } else {
      return Left(DeleteFailure('error'));
    }
  }

  @override
  Future<Either<Failure, NoteEntity>?> getNote(int id) async {
    NotesModel? model = await _notesSource.getData(id);

    NoteEntity? entity = NoteEntity(
        title: model?.title,
        content: model?.content,
        isPinned: model?.isPinned,
        date: model?.date);

    return Right(entity);
  }

  @override
  Future<Either<Failure, List<NoteEntity>>?> getNotes() async {
    List<NoteEntity>? result = [];

    try {
      await _notesSource.getListOfData().then((value) {
        value!.forEach((e) {
          result.add(e.toEntity());
        });
      });
    } catch (e) {
      print(e);
      return Left(GetNotesFailure(e.toString()));
    }
    return Right(result);
  }

  @override
  Future<Either<Failure, bool>?> updateNote(NoteEntity updatedNote) async {
    NotesModel model = NotesModel(
        title: updatedNote.title,
        content: updatedNote.content,
        isPinned: updatedNote.isPinned,
        date: updatedNote.date,
        id: updatedNote.id);
    NoteEntity? result;

    try {
      await _notesSource.updateData(model).then((value) {
        return Right(true);
      });
    } catch (e) {
      throw e;
      return Left(UpdateFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>?>?> searchNote(String search) async {
    List<NoteEntity> result = [];
    try {
      await _notesSource.searchData(search).then((value) {
        result = value!;
      });
    } catch (e) {
      // throw e;
      return Left(UpdateFailure(e.toString()));
    }
    print(' my search list : $result');
    return Right(result);
  }
}
