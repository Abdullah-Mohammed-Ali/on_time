part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesInitial extends NotesState {
  @override
  List<Object> get props => [];
}

// start creating note states...
class CreateNoteLoadingState extends NotesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreateNoteSuccessLoadingState extends NotesState {
  @override
// TODO: implement props
  List<Object?> get props => [];
}

class CreateNoteErrorLoadingState extends NotesState {
  @override
// TODO: implement props
  List<Object?> get props => [];
}

// end of creating note states...

// start get note states...
class GetNoteLoadingState extends NotesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetNoteSuccessLoadingState extends NotesState {
  final NoteEntity result;

  const GetNoteSuccessLoadingState(this.result);
  @override
// TODO: implement props
  List<Object?> get props => [result];
}

class GetNoteErrorLoadingState extends NotesState {
  final String errorMessage;

  const GetNoteErrorLoadingState(this.errorMessage);
  @override
// TODO: implement props
  List<Object?> get props => [errorMessage];
}

// end of get note states...

class GetNotesLoadingState extends NotesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetNotesSuccessLoadingState extends NotesState {
  final List<NoteEntity> result;

  const GetNotesSuccessLoadingState(this.result);
  @override
// TODO: implement props
  List<Object?> get props => [result];
}

class GetNotesErrorLoadingState extends NotesState {
  final String errorMessage;

  const GetNotesErrorLoadingState(this.errorMessage);
  @override
// TODO: implement props
  List<Object?> get props => [errorMessage];
}

// start Update note states...
class UpdateNoteLoadingState extends NotesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateNoteSuccessLoadingState extends NotesState {
  final bool isUpdated;

  const UpdateNoteSuccessLoadingState(this.isUpdated);
  @override
// TODO: implement props
  List<Object?> get props => [isUpdated];
}

class UpdateNoteErrorLoadingState extends NotesState {
  final String errorMessage;

  const UpdateNoteErrorLoadingState(this.errorMessage);
  @override
// TODO: implement props
  List<Object?> get props => [];
}

// end of Update note states...

// start delete note states...
class DeleteNoteLoadingState extends NotesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteNoteSuccessLoadingState extends NotesState {
  final bool state;
  const DeleteNoteSuccessLoadingState(this.state);
  @override
// TODO: implement props
  List<Object?> get props => [state];
}

class DeleteNoteErrorLoadingState extends NotesState {
  final String errorMessage;

  const DeleteNoteErrorLoadingState(this.errorMessage);
  @override
// TODO: implement props
  List<Object?> get props => [];
}

// end of delete note states...

// start of search note states...

class SearchLoadingState extends NotesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchSuccessState extends NotesState {
  final List<NoteEntity> result;

  const SearchSuccessState(this.result);
  @override
// TODO: implement props
  List<Object?> get props => [result];
}

class SearchErrorState extends NotesState {
  final String errorMessage;

  const SearchErrorState(this.errorMessage);
  @override
// TODO: implement props
  List<Object?> get props => [];
}
