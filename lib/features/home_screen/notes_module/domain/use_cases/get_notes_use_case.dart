import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';

class GetNotesUseCase implements UseCases<List<NoteEntity>, NoParam> {
  final NotesRepo _notesRepo;

  GetNotesUseCase(this._notesRepo);
  @override
  Future<Either<Failure, List<NoteEntity>>?> call(NoParam noParam) async {
    return await _notesRepo.getNotes();
  }
}

class NoParam {}
