import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_time/const/colors.dart';
import 'package:on_time/features/home_screen/notes_module/domain/entities/note_entity.dart';
import 'package:on_time/features/home_screen/notes_module/presentation/widgets/note_text_field.dart';
import 'package:on_time/routing.dart';

import '/dependency_container.dart' as di;
import '../../../../const/functions.dart';
import '../../presentation/widgets/app_bar.dart';
import 'bloc/notes_bloc.dart';

class CreateNoteScreen extends StatefulWidget {
  CreateNoteScreen({Key? key, this.editedNote}) : super(key: key);
  NoteEntity? editedNote;

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  var titleController = TextEditingController();

  var contentController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPinned = false;

  @override
  void initState() {
    NoteEntity? editedNote = widget.editedNote;

    if (editedNote != null) {
      titleController.text = editedNote.title!;
      contentController.text = editedNote.content!;
      isPinned = intToBool(editedNote.isPinned);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<NotesBloc>(),
      child: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          NoteEntity? editedNote = widget.editedNote;

          var noteBloc = NotesBloc.get(context);

          return Form(
            key: formKey,
            child: Scaffold(
              appBar: myAppBar(
                context: context,
                backgroundColor: MyColors.splashBackGroundColor,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                    onPressed: () {
                      cancelNote(noteBloc, context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      isPinned = !isPinned;
                      setState(() {});
                    },
                    icon: Icon(
                      isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      size: 20.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (editedNote != null) {
                        NoteEntity editedNoteCopy = NoteEntity(
                          title: titleController.text,
                          content: contentController.text,
                          isPinned: boolToIntConverter(isPinned),
                          date: editedNote.date,
                          id: editedNote.id,
                        );

                        editNote(noteBloc, editedNoteCopy, context);
                      } else {
                        createNote(noteBloc, context, isPinned);
                      }
                    },
                    icon: Icon(
                      Icons.check,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
              body: Container(
                color: MyColors.splashBackGroundColor,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: NoteTextFormField(
                        validatorText: 'please enter title first',
                        hintText: 'title',
                        contentController: titleController,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: NoteTextFormField(
                          contentController: contentController,
                          validatorText: 'please enter content first',
                          hintText: 'content',
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void cancelNote(noteBloc, context) {
    noteBloc.add(GetNotesEvent());
    Navigator.pushReplacementNamed(context, RoutesName.home);
  }

  void createNote(NotesBloc noteBloc, context, isPinned) {
    if (formKey.currentState!.validate()) {
      String title = titleController.text;
      String content = contentController.text;
      String date = DateTime.now().toIso8601String();
      int isPinnedInt = boolToIntConverter(isPinned);
      noteBloc.add(CreateNoteEvent(title, content, date, isPinnedInt));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Note has been created')));
      titleController.clear();
      contentController.clear();
      Navigator.pushReplacementNamed(context, RoutesName.home);
    }
  }

  void editNote(NotesBloc noteBloc, NoteEntity updatedNote, context) {
    if (formKey.currentState!.validate()) {
      noteBloc.add(UpdateNoteEvent(updatedNote));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Note has been Edited')));
      titleController.clear();
      contentController.clear();
      Navigator.pushReplacementNamed(context, RoutesName.home);
    }
  }
}
