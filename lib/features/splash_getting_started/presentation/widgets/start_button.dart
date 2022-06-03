import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.w),
      child: SizedBox(
        height: 40.h,
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text(
            'Start',
            style: TextStyle(color: Colors.black),
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.white)),
        ),
      ),
    );
  }
}
