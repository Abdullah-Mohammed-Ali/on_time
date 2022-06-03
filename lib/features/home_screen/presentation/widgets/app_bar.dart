import 'package:flutter/material.dart';

import '../../../../const/colors.dart';

AppBar myAppBar({
  required BuildContext context,
  double elevation = 0,
  Widget? leading,
  List<Widget>? actions,
  Color backgroundColor = MyColors.splashBackGroundColor,
}) {
  return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: leading,
      actions: actions);
}
