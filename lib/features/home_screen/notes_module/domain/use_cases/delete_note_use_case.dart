import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';

class DeleteNoteUseCase implements UseCases<bool, DeleteNoteParams> {
  final NotesRepo _notesRepo;

  DeleteNoteUseCase(this._notesRepo);
  @override
  Future<Either<Failure, bool>?> call(DeleteNoteParams deleteNoteParams) async {
    return await _notesRepo.deleteNote(deleteNoteParams.id);
  }
}

class DeleteNoteParams {
  final int id;

  DeleteNoteParams(this.id);
}
