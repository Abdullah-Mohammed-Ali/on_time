import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';

class NotesModel extends NoteEntity {
  NotesModel(
      {required String? title,
      int? id,
      required String? content,
      required int? isPinned,
      required String? date})
      : super(
            title: title,
            content: content,
            isPinned: isPinned,
            date: date,
            id: id);

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      isPinned: map['isPinned'],
      date: map['date'],
    );
  }
  NoteEntity toEntity() {
    NoteEntity noteEntity = NoteEntity(
        title: title, content: content, isPinned: isPinned, date: date, id: id);
    return noteEntity;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'isPinned': isPinned,
      'date': date,
      'id': id
    };
  }
}
