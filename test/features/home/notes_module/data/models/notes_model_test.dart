import 'package:flutter_test/flutter_test.dart';
import 'package:on_time/features/home_screen/notes_module/data/models/notes_model.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';

void main() {
  late NotesModel notesModel;
  Map<String, dynamic> testMap = {
    'title': 'test',
    'content': 'content test',
    'isPinned': false,
    'date': 'test date',
  };

  setUp(() {
    notesModel = NotesModel(
      content: 'content test',
      isPinned: 0,
      date: 'test date',
      title: 'test',
    );
  });

  test('make sure note model is a note entities', () {
    //arrange
    notesModel = NotesModel(title: '', content: '', date: '', isPinned: 0);
    expect(notesModel, isA<NoteEntity>());
  });

  group('from map testing', () {
    test('return map', () {
      final result = NotesModel.fromMap(testMap);

      expect(result, notesModel);
    });
  });

  group('to map testing', () {
    test('return map', () {
      final result = notesModel.toMap();

      expect(result, testMap);
    });
  });
}
