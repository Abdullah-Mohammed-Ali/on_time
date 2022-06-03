import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../const/colors.dart';

class PickDateOrTime extends StatelessWidget {
  const PickDateOrTime({
    Key? key,
    required this.dateController,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController dateController;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  textAlign: TextAlign.center,
                  controller: dateController,
                  enabled: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: MyColors().eventTextColor),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: MyColors().eventTextColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
