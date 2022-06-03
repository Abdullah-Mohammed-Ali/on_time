import 'package:dartz/dartz.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';

import '../../../../../core/errors/failure.dart';

abstract class NotesRepo {
  Future<Either<Failure, bool>?> createNote(NoteEntity noteEntity);
  Future<Either<Failure, List<NoteEntity>>?> getNotes();
  Future<Either<Failure, NoteEntity>?> getNote(int id);
  Future<Either<Failure, bool>?> updateNote(NoteEntity updatedNote);
  Future<Either<Failure, bool>?> deleteNote(int id);
  Future<Either<Failure, List<NoteEntity>?>?> searchNote(String search);
}
