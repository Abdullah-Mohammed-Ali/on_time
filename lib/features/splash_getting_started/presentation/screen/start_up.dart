import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_time/core/widgets/my_scaffold.dart';
import 'package:on_time/features/splash_getting_started/presentation/widgets/title_header.dart';
import 'package:on_time/routing.dart';

import '../cashed_bloc/cashed_bloc.dart';
import '../widgets/start_button.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('launching');
    return BlocBuilder<CashedBloc, CashedState>(
      builder: (context, state) {
        return MyScaffold(body: BlocBuilder<CashedBloc, CashedState>(
          builder: (context, state) {
            var cashedBloc = CashedBloc.get(context);

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTitleHeader(
                  fontSize: 55.sp,
                  fontWeight: FontWeight.bold,
                ),
                const MySlogoan(),
                StartButton(
                  onPressed: () {
                    // cashedBloc.add(SaveDataEvent('first time', true));
                    Navigator.pushReplacementNamed(context, RoutesName.home);
                  },
                )
              ],
            );
          },
        ));
      },
    );
  }
}
