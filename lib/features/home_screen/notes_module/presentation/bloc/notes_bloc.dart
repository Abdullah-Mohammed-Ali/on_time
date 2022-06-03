import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/delete_note_use_case.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/search_note_use_case.dart';
import 'package:on_time/features/home_screen/notes_module/domain/use_cases/update_note_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../domain/use_cases/create_note_use_case.dart';
import '../../domain/use_cases/get_note_use_case.dart';
import '../../domain/use_cases/get_notes_use_case.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final CreateNoteUseCase _createUseCase;

  final GetNoteUseCase _getUseCase;
  final GetNotesUseCase _getNotesUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
  final SearchNoteUseCase _searchNoteUseCase;

  CreateParms createdNoteParams(
      {required String title,
      required String content,
      required String date,
      required int isPinned}) {
    NoteEntity createNoteEntity = NoteEntity(
        title: title, content: content, isPinned: isPinned, date: date);
    return CreateParms(createNoteEntity);
  }

  static NotesBloc get(context) => BlocProvider.of(context);

  NotesBloc(
    this._createUseCase,
    this._getUseCase,
    this._getNotesUseCase,
    this._deleteNoteUseCase,
    this._updateNoteUseCase,
    this._searchNoteUseCase,
  ) : super(NotesInitial()) {
    on<NotesEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is CreateNoteEvent) {
        emit(CreateNoteLoadingState());
        CreateParms createParms = createdNoteParams(
            title: event.title,
            content: event.content,
            date: event.date,
            isPinned: event.isPinned);
        final createdNoteResult = await _createUseCase.call(createParms);
        createdNoteResult!.fold(
          (l) {
            emit(CreateNoteErrorLoadingState());
          },
          (r) {
            emit(CreateNoteSuccessLoadingState());
          },
        );
      } else if (event is GetNoteEvent) {
        GetNoteParams getNoteParams = GetNoteParams(event.id);
        final getNoteResult = await _getUseCase.call(getNoteParams);
        getNoteResult!.fold(
          (l) {
            emit(GetNoteErrorLoadingState('error getting the note try again'));
          },
          (r) {
            emit(GetNoteSuccessLoadingState(r));
          },
        );
      } else if (event is UpdateNoteEvent) {
        UpdateParams updateParams = UpdateParams(event.updatedNote);
        final updateNoteResult = await _updateNoteUseCase(updateParams);
        updateNoteResult!.fold(
            (l) => emit(UpdateNoteErrorLoadingState(l.errorMessage)),
            (r) => emit(UpdateNoteSuccessLoadingState(r)));
      } else if (event is DeleteNoteEvent) {
        DeleteNoteParams deleteNoteParams = DeleteNoteParams(event.id);
        final getNotesResult = await _deleteNoteUseCase(deleteNoteParams);
        getNotesResult!.fold(
          (l) {
            emit(DeleteNoteErrorLoadingState('error deleting notes try again'));
          },
          (r) {
            print('');
            emit(DeleteNoteSuccessLoadingState(r));
          },
        );
      } else if (event is GetNotesEvent) {
        final getNotesResult = await _getNotesUseCase(NoParam());
        getNotesResult!.fold(
          (l) {
            emit(GetNotesErrorLoadingState('error getting notes try again'));
          },
          (r) {
            emit(GetNotesSuccessLoadingState(r));
          },
        );
      } else if (event is SearchNoteUseEvent) {
        SearchParams searchParams = SearchParams(event.search);
        final result = await _searchNoteUseCase.call(searchParams);
        result!.fold(
          (l) => GetNoteFailure(l.errorMessage),
          (r) => emit(
            SearchSuccessState(r!),
          ),
        );
      }
    });
  }
}
