import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/update_note_use_case.dart';

class MockNotesRepo extends Mock implements NotesRepo {}

void main() {
  late UpdateNoteUseCase sut;
  late MockNotesRepo mockNotesRepo;
  setUp(() {
    mockNotesRepo = MockNotesRepo();
    sut = UpdateNoteUseCase(mockNotesRepo);
  });

  initMockMethod(id, field, value, result) {
    when(() => mockNotesRepo.updateNote(value))
        .thenAnswer((invocation) async => result);
  }

  group('get note testing', () {
    NoteEntity noteEntity = NoteEntity(
        title: 'title', content: 'content', isPinned: 0, date: 'date');

    UpdateParams updateNoteParams = UpdateParams(noteEntity);
    Right<Failure, NoteEntity> right = Right(noteEntity);

    test('make sure start is correct', () async {
      //arrange
      initMockMethod(1, 'title', 'test update', right);

      final future = await sut(updateNoteParams);
      verify(() => mockNotesRepo.updateNote(updateNoteParams.updateNote))
          .called(1);
    });
    test('make sure that return NoteEntity', () async {
      //arrange
      initMockMethod(1, 'title', 'test update', right);
// act
      final future = await sut(updateNoteParams);
      //assert
      expect(future, right);
    });
  });
}
