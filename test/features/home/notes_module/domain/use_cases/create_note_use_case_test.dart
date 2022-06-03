import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/repos/notes_repo.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/create_note_use_case.dart';

class MockNotesRepo extends Mock implements NotesRepo {}

void main() {
  late CreateNoteUseCase sut;
  late MockNotesRepo mockNotesRepo;

  setUp(() {
    mockNotesRepo = MockNotesRepo();
    sut = CreateNoteUseCase(mockNotesRepo);
  });

  initMockMethod(noteEntity, result) {
    CreateParms createParms = CreateParms(noteEntity);
    when(() => mockNotesRepo.createNote(noteEntity))
        .thenAnswer((invocation) async => result);
  }

  group('creating note tests', () {
    Right<Failure, bool> result = Right(true);
    NoteEntity noteEntity = NoteEntity(
        title: 'title', content: 'content', isPinned: 0, date: 'date');
    CreateParms createParms = CreateParms(noteEntity);

    test('make sure create note is called', () async {
      //arrange

      when(() => mockNotesRepo.createNote(noteEntity))
          .thenAnswer((invocation) async => null);
      //act
      final future = sut(createParms);
      //assert
      verify(() => mockNotesRepo.createNote(noteEntity)).called(1);
      expect(sut.isCreating, true);
    });
    test('call create and return true', () async {
      //arrange

      initMockMethod(noteEntity, result);
      //act
      final future = sut(createParms);
      //assert
      var values;
      await future.then((value) => values = value);
      expect(values, const Right(true));
    });
  });
}
