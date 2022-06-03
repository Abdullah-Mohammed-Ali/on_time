import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';

class CreateNoteUseCase implements UseCases<bool, CreateParms> {
  final NotesRepo _notesRepo;

  CreateNoteUseCase(this._notesRepo);
  bool isCreating = false;
  @override
  Future<Either<Failure, bool>?> call(CreateParms params) async {
    // TODO: implement call
    isCreating = true;
    return await _notesRepo.createNote(params.noteEntity);
  }
}

class CreateParms {
  final NoteEntity noteEntity;

  CreateParms(this.noteEntity);
}
