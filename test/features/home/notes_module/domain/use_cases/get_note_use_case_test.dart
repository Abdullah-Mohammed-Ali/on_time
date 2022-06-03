import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/get_note_use_case.dart';

class MockNotesRepo extends Mock implements NotesRepo {}

void main() {
  late GetNoteUseCase sut;
  late MockNotesRepo mockNotesRepo;
  setUp(() {
    mockNotesRepo = MockNotesRepo();
    sut = GetNoteUseCase(mockNotesRepo);
  });

  initMockMethod(title, result) {
    when(() => mockNotesRepo.getNote(title))
        .thenAnswer((invocation) async => result);
  }

  group('get note testing', () {
    GetNoteParams getNoteParams = GetNoteParams(1);
    NoteEntity noteEntity = NoteEntity(
        title: 'title', content: 'content', isPinned: 0, date: 'date');
    Right<Failure, NoteEntity> right = Right(noteEntity);

    test('make sure start is correct', () async {
      //arrange
      initMockMethod(1, right);

      final future = await sut(getNoteParams);
      verify(() => mockNotesRepo.getNote(getNoteParams.id)).called(1);
    });
    test('make sure that return NoteEntity', () async {
      //arrange
      initMockMethod(1, right);
// act
      final future = await sut(getNoteParams);
      //assert
      expect(future, right);
    });
  });
}
