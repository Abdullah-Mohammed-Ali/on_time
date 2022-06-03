import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_time/features/splash_getting_started/presentation/cashed_bloc/cashed_bloc.dart';

import '../../../../core/widgets/my_scaffold.dart';
import '../../../../routing.dart';
import '../widgets/title_header.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print('start');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashedBloc, CashedState>(
      builder: (context, state) {
        var cashedBloc = CashedBloc.get(context);

        if (state is CashedInitial) {
          return MyScaffold(
            body: const MyTitleHeader(),
          );
        } else if (state is CashedGetSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await Future.delayed(const Duration(milliseconds: 1500));
            Navigator.pushReplacementNamed(context, RoutesName.home);
          });
        }
        return MyScaffold(
          body: const MyTitleHeader(),
        );
      },
    );
  }
}
