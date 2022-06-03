import 'package:flutter/material.dart';

import '../bloc/notes_bloc.dart';
import 'note_item.dart';

Widget ListofNotes(state, NotesBloc noteBloc) {
  if (state is GetNotesSuccessLoadingState || state is SearchSuccessState) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return NoteItem(
            noteItem: state.result[index],
            onDeletePress: () {
              noteBloc.add(DeleteNoteEvent(state.result[index].id!));
              Navigator.pop(context);
              noteBloc.add(GetNotesEvent());
            },
          );
        },
        itemCount: state.result.length,
      ),
    );
  } else {
    return Container();
  }
}
