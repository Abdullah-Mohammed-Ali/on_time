import 'package:flutter/material.dart';
import 'package:on_time/routing.dart';

import '../../../../../const/colors.dart';
import '../../../../../const/strings.dart';
import '../../domain/entities/note_entity.dart';

class NoteItem extends StatelessWidget {
  final NoteEntity noteItem;
  final Function() onDeletePress;
  NoteItem({
    Key? key,
    required this.noteItem,
    required this.onDeletePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detailss;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.createNote,
            arguments: noteItem);
      },
      onLongPress: () {
        showMenu(
            context: context,
            position: RelativeRect.fromLTRB(detailss.dx, detailss.dy, 0, 0),
            items: [
              PopupMenuItem(
                child: TextButton(
                  onPressed: onDeletePress,
                  child: Text('Delete'),
                ),
              )
            ]);
      },
      onTapDown: (details) {
        detailss = details.globalPosition;
        print(details.globalPosition);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.splashBackGroundColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noteItem.title!,
                  style: noteCard(context),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  noteItem.content!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: noteCard(context),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      noteItem.date ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white.withOpacity(0.6)),
                    ),
                    Spacer(),
                    noteItem.isPinned == 1
                        ? Icon(
                            Icons.push_pin,
                            size: 15,
                            color: Colors.white,
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
