import 'package:flutter/material.dart';

import '../../const/colors.dart';

class MyScaffold extends StatelessWidget {
  MyScaffold({
    required this.body,
    Key? key,
    this.appBar,
    this.bottomNavigationBar,
    this.myFloatingButton,
  }) : super(key: key);
  final Widget body;
  final Widget? myFloatingButton;
  AppBar? appBar;
  late BottomAppBar? bottomNavigationBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      floatingActionButton: myFloatingButton,
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
                decoration:
                    BoxDecoration(gradient: MyColors().mainLinearGradient),
                child: SafeArea(child: body)),
          ],
        ),
      ),
    );
  }
}
