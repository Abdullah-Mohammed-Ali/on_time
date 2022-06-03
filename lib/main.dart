import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_time/const/colors.dart';
import 'package:on_time/routing.dart';

import 'core/bloc_observer.dart';
import 'dependency_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(() => runApp(MyApp()), blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(785, 360),
      child: MaterialApp(
        theme: ThemeData(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: MyColors.splashBackGroundColor)),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splash,
        onGenerateRoute: MyRoutes().onGenerateRoute,
      ),
    );
  }
}
