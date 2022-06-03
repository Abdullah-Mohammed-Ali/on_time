import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_time/routing.dart';

import '../../../const/colors.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().menuBackGroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              bottom: 20.h,
              right: 20.w,
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: [
                  MyFloatingButton(
                    buttonIcon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyFloatingButton(
                    heroTag: 'calendar',
                    buttonIcon: Icon(
                      Icons.calendar_today,
                      size: 20.sp,
                    ),
                    radius: 50,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RoutesName.eventsScreen);
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyFloatingButton(
                      heroTag: 'note',
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesName.createNote);
                      },
                      buttonIcon: Icon(
                        Icons.note_add_outlined,
                        size: 20.sp,
                      ),
                      radius: 50),
                ],
              )),
        ],
      ),
    );
  }
}

class MyFloatingButton extends StatelessWidget {
  final double radius;
  final Icon buttonIcon;
  final String heroTag;
  final Function() onPressed;
  const MyFloatingButton({
    this.radius = 60,
    Key? key,
    required this.buttonIcon,
    required this.onPressed,
    this.heroTag = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius,
      width: radius,
      child: FloatingActionButton(
        heroTag: heroTag,
        child: buttonIcon,
        onPressed: onPressed,
      ),
    );
  }
}
