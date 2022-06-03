import 'package:flutter/material.dart';

class Inheritance extends InheritedWidget {
  Inheritance({required this.name, required this.score, required Widget child})
      : super(child: child);
  final int score;
  final String name;

  @override
  bool updateShouldNotify(covariant Inheritance oldWidget) {
    print(score != oldWidget.score);
    return score != oldWidget.score;
  }

  static Inheritance of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Inheritance>()!;
  }
}
