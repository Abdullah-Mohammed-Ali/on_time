import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';

class SearchNoteUseCase implements UseCases<List<NoteEntity>?, SearchParams> {
  final NotesRepo _notesRepo;

  SearchNoteUseCase(this._notesRepo);

  @override
  Future<Either<Failure, List<NoteEntity>?>?> call(SearchParams search) async {
    return await _notesRepo.searchNote(search.search);
  }
}

class SearchParams {
  final String search;

  SearchParams(this.search);
}
