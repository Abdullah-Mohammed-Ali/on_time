import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  int? id;
  final String? title;
  final String? content;
  final int? isPinned;
  final String? date;
  NoteEntity(
      {required this.title,
      this.id,
      required this.content,
      required this.isPinned,
      required this.date})
      : super();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
