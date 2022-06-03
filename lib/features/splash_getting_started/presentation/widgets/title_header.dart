import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../const/strings.dart';

class MyTitleHeader extends StatelessWidget {
  const MyTitleHeader({
    this.fontSize = 45,
    this.fontWeight = FontWeight.w500,
    Key? key,
  }) : super(key: key);
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
                child: SvgPicture.asset(
              'assets/color.svg',
              height: 100.h,
              theme: const SvgTheme(currentColor: Colors.white),
            )),
          ),
        ],
      ),
    );
  }
}

class MySlogoan extends StatelessWidget {
  const MySlogoan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      slogan,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline4!.copyWith(
          color: Colors.white, fontWeight: FontWeight.w200, fontSize: 30.sp),
    );
  }
}
