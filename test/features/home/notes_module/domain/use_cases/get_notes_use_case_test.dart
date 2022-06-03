import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/get_notes_use_case.dart';

class MockNotesRepo extends Mock implements NotesRepo {}

void main() {
  late GetNotesUseCase sut;
  late MockNotesRepo mockNotesRepo;
  setUp(() {
    mockNotesRepo = MockNotesRepo();
    sut = GetNotesUseCase(mockNotesRepo);
  });

  initMockMethod(result) {
    when(() => mockNotesRepo.getNotes())
        .thenAnswer((invocation) async => result);
  }

  group('get notes testing', () {
    NoteEntity noteEntity1 = NoteEntity(
        title: 'title', content: 'content', isPinned: 0, date: 'date');
    NoteEntity noteEntity2 = NoteEntity(
        title: 'title', content: 'content', isPinned: 0, date: 'date');
    NoteEntity noteEntity3 = NoteEntity(
        title: 'title', content: 'content', isPinned: 0, date: 'date');

    List<NoteEntity> result = [noteEntity1, noteEntity2, noteEntity3];
    Right<Failure, List<NoteEntity>> right = Right(result);

    test('make sure start is correct', () async {
      //arrange
      initMockMethod(right);

      final future = await sut(NoParam());
      verify(() => mockNotesRepo.getNotes()).called(1);
    });
    test('make sure that return NoteEntity', () async {
      //arrange
      initMockMethod(right);
// act
      final future = await sut(NoParam());
      //assert
      expect(future, right);
    });
  });
}
