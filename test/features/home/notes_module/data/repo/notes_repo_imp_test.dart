import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/features/home_screen/notes_module/data/data_source/notes_data_source.dart';
import 'package:on_time/features/home_screen/notes_module/data/models/notes_model.dart';
import 'package:on_time/features/home_screen/notes_module/data/repo/note_repo_imp.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';

class TestParams {}

class MockNoteDataSource extends Mock implements NotesDataSource {}

void main() {
  late NotesRepoImp sut;
  late MockNoteDataSource mockNoteDataSource;
  late DataSourceParams dataSourceParams;
  late NoteEntity noteEntity;
  late NotesModel fromEntity;

  setUp(() {
    mockNoteDataSource = MockNoteDataSource();
    noteEntity = NoteEntity(
        title: 'title', content: 'content', isPinned: 0, date: 'date');
    fromEntity = NotesModel(
        title: noteEntity.title,
        content: noteEntity.content,
        isPinned: noteEntity.isPinned,
        date: noteEntity.date);
    dataSourceParams = DataSourceParams(fromEntity, 1);
    sut = NotesRepoImp(mockNoteDataSource);
  });

  group('create note test', () {
    test('ensure initialization', () async {
      when(() => mockNoteDataSource.createData(fromEntity))
          .thenAnswer((_) async => false);
      final expectedResult = await sut.createNote(noteEntity);

      verify(() => mockNoteDataSource.createData(fromEntity)).called(1);
      expect(expectedResult, const Right<Failure, bool>(false));
    });
  });

  group('get note test', () {
    test('ensure initialization', () async {
      Right<Failure, NoteEntity> result = Right(noteEntity);
      when(() => mockNoteDataSource.getData(1))
          .thenAnswer((_) async => fromEntity);
      final expectedResult = await sut.getNote(1);

      verify(() => mockNoteDataSource.getData(1)).called(1);
      expect(expectedResult, result);
    });
  });

  group('get notes test', () {
    NoteEntity noteEntity = NoteEntity(
        title: 'title', content: 'content', isPinned: 0, date: 'date');
    NotesModel fromEntity = NotesModel(
        title: noteEntity.title,
        content: noteEntity.content,
        isPinned: noteEntity.isPinned,
        date: noteEntity.date);

    test('ensure initialization', () async {
      when(() => mockNoteDataSource.createData(fromEntity))
          .thenAnswer((_) async => false);
      final expectedResult = await sut.createNote(noteEntity);

      verify(() => mockNoteDataSource.createData(fromEntity)).called(1);
      expect(expectedResult, const Right<Failure, bool>(false));
    });
  });

  group('update note test', () {
    NoteEntity noteEntity = NoteEntity(
        title: 'title', content: 'content', isPinned: 0, date: 'date');
    NotesModel fromEntity = NotesModel(
        title: noteEntity.title,
        content: noteEntity.content,
        isPinned: noteEntity.isPinned,
        date: noteEntity.date);
    test('ensure initialization', () async {
      when(() => mockNoteDataSource.updateData(fromEntity))
          .thenAnswer((_) async => true);
      final expectedResult = await sut.updateNote(fromEntity);

      verify(() => mockNoteDataSource.updateData(fromEntity)).called(1);
      expect(expectedResult, Right<Failure, NoteEntity>(fromEntity));
    });
  });

  group('delete note test', () {
    test('ensure initialization', () async {
      when(() => mockNoteDataSource.deleteData(1))
          .thenAnswer((_) async => false);
      final expectedResult = await sut.deleteNote(1);

      verify(() => mockNoteDataSource.deleteData(1)).called(1);
      expect(expectedResult, const Right<Failure, bool>(false));
    });
  });
}
