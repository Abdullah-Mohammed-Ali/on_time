import 'package:flutter/material.dart';

const Color mainLinearGradientColor = Color(0xff2B125A);
const Color secondLinearGradientColor = Color(0xff2A2A2E);

class MyColors {
  Color menuBackGroundColor = Color(0xff36364A);
  Color switchColor = Color(0xff282530);

  static const Color splashBackGroundColor = Color(0xeb876ffc);
  Color searchFillGroundColor = Color(0xffCCC2FE);
  Color eventRightTextColor = Color(0xff828282);
  Color dayEdgeColor = Color(0xff7E64FF);
  Color doneEventColor = Color(0xff241641);
  Color notDoneEventColor = Color(0xff3C1F7B);

  Color eventTextColor = Color(0xff4F4F4F);
  Color tabBarColor = Color(0xff3C1F7B);
  Color tabBarEnabledColor = Color(0xff272430);
  Color holidayCalendarColor = Color(0xffFF636C);

  LinearGradient mainLinearGradient = const LinearGradient(
    colors: [
      secondLinearGradientColor,
      mainLinearGradientColor,
      Colors.black,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
