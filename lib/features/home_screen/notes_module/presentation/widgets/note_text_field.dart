import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../const/strings.dart';

class NoteTextFormField extends StatelessWidget {
  final String validatorText;
  final String hintText;
  int? maxLines;
  TextInputType? keyBoardType;
  NoteTextFormField({
    Key? key,
    maxLines = 1,
    keyboardType = TextInputType.text,
    required this.contentController,
    required this.validatorText,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: TextFormField(
        validator: (value) {
          if (value == '') {
            return validatorText;
          }
        },
        keyboardType: keyBoardType,
        maxLines: maxLines,
        controller: contentController,
        style: noteTextStyle(context),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: noteTextStyle(context),
        ),
      ),
    );
  }
}
