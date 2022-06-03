import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_time/const/colors.dart';
import 'package:on_time/features/home_screen/notes_module/presentation/bloc/notes_bloc.dart';

class SearchTextField extends StatelessWidget {
  final NotesBloc bloc;
  SearchTextField({Key? key, required this.bloc}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
      child: SizedBox(
        height: 40.h,
        child: TextFormField(
          controller: searchController,
          autofocus: false,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 18),
            filled: true,
            suffixIcon: IconButton(
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  bloc.add(SearchNoteUseEvent(searchController.text));
                }
              },
              icon: const Icon(Icons.search),
            ),
            fillColor: MyColors().searchFillGroundColor,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
