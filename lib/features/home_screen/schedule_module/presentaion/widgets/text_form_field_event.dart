import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_time/const/colors.dart';

import '../../../../../const/strings.dart';

class EventTextFormField extends StatelessWidget {
  final String validatorText;
  final String hintText;
  int? maxLines;
  TextInputType? keyBoardType;
  EventTextFormField({
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
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: 35.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        validator: (value) {
          if (value == '') {
            return validatorText;
          }
        },
        textInputAction: TextInputAction.go,
        keyboardType: keyBoardType,
        maxLines: maxLines,
        controller: contentController,
        style: eventCard(context),
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors().searchFillGroundColor,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: eventCard(context),
        ),
      ),
    );
  }
}
