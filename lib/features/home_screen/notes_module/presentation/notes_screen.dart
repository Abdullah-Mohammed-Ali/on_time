import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_time/features/home_screen/notes_module/presentation/bloc/notes_bloc.dart';
import 'package:on_time/features/home_screen/notes_module/presentation/widgets/note_list.dart';
import 'package:on_time/features/home_screen/notes_module/presentation/widgets/search.dart';

import '/dependency_container.dart' as di;

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<NotesBloc>()..add(GetNotesEvent()),
      child: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var noteBloc = NotesBloc.get(context);

          return Column(
            children: [
              SearchTextField(
                bloc: noteBloc,
              ),
              ListofNotes(state, noteBloc)
            ],
          );
        },
      ),
    );
  }
}
