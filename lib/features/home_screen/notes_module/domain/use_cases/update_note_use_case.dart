import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';

class UpdateNoteUseCase implements UseCases<bool, UpdateParams> {
  final NotesRepo _notesRepo;

  UpdateNoteUseCase(this._notesRepo);
  @override
  Future<Either<Failure, bool>?> call(UpdateParams updateParams) async {
    final result = await _notesRepo.updateNote(updateParams.updateNote);
    return await _notesRepo.updateNote(updateParams.updateNote);
  }
}

class UpdateParams {
  final NoteEntity updateNote;

  UpdateParams(this.updateNote);
}
