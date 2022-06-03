import 'package:flutter/material.dart';

import '../../../../../const/strings.dart';

class EventRow extends StatelessWidget {
  const EventRow({
    Key? key,
    required this.title,
    required this.action,
  }) : super(key: key);
  final String title;
  final Widget action;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        children: [
          Text(
            title,
            style: eventTextStyleRow(context),
          ),
          const Spacer(
            flex: 1,
          ),
          action
        ],
      ),
    );
  }
}
