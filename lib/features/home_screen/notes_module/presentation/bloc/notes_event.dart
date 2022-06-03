part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class CreateNoteEvent extends NotesEvent {
  final String title;
  final String content;
  final String date;
  final int isPinned;
  const CreateNoteEvent(this.title, this.content, this.date, this.isPinned);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetNoteEvent extends NotesEvent {
  final int id;

  GetNoteEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class GetNotesEvent extends NotesEvent {
  @override
// TODO: implement props
  List<Object?> get props => [];
}

class SearchNoteUseEvent extends NotesEvent {
  final String search;

  SearchNoteUseEvent(this.search);
  @override
// TODO: implement props
  List<Object?> get props => [search];
}

class UpdateNoteEvent extends NotesEvent {
  final NoteEntity updatedNote;

  UpdateNoteEvent(this.updatedNote);
  @override
// TODO: implement props
  List<Object?> get props => [];
}

class DeleteNoteEvent extends NotesEvent {
  final int id;

  DeleteNoteEvent(this.id);
  @override
// TODO: implement props
  List<Object?> get props => [];
}
