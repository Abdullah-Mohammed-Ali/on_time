part of 'cashed_bloc.dart';

@immutable
abstract class CashedEvent {}

class SaveDataEvent extends CashedEvent {
  final String key;
  final dynamic value;

  SaveDataEvent(this.key, this.value);
}

class GetDataEvent extends CashedEvent {
  final String key;

  GetDataEvent(this.key);
}
