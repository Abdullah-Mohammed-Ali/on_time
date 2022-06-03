import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/delete_note_use_case.dart';

class MockNotesRepo extends Mock implements NotesRepo {}

void main() {
  late DeleteNoteUseCase sut;
  late MockNotesRepo mockNotesRepo;
  setUp(() {
    mockNotesRepo = MockNotesRepo();
    sut = DeleteNoteUseCase(mockNotesRepo);
  });

  initMockMethod(id, result) {
    when(() => mockNotesRepo.deleteNote(id))
        .thenAnswer((invocation) async => result);
  }

  group('get note testing', () {
    DeleteNoteParams deleteNoteParams = DeleteNoteParams(1);

    Right<Failure, bool> right = const Right(false);

    test('make sure start is correct', () async {
      //arrange
      initMockMethod(1, right);

      final future = await sut(deleteNoteParams);
      verify(() => mockNotesRepo.deleteNote(deleteNoteParams.id)).called(1);
    });
    test('make sure that return NoteEntity', () async {
      //arrange
      initMockMethod(1, right);
// act
      final future = await sut(deleteNoteParams);
      //assert
      expect(future, right);
    });
  });
}
