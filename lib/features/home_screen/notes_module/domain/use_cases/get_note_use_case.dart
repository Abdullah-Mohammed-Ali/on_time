import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';

class GetNoteUseCase implements UseCases<NoteEntity, GetNoteParams> {
  final NotesRepo _notesRepo;

  GetNoteUseCase(this._notesRepo);
  @override
  Future<Either<Failure, NoteEntity>?> call(GetNoteParams getNoteParams) async {
    // TODO: implement call
    return await _notesRepo.getNote(getNoteParams.id);
  }
}

class GetNoteParams {
  final int id;

  GetNoteParams(this.id);
}
