part of 'cashed_bloc.dart';

@immutable
abstract class CashedState {}

class CashedInitial extends CashedState {}

class CashedSavedSuccess extends CashedState {
  final bool result;

  CashedSavedSuccess(this.result);
}

class CashedSavedError extends CashedState {
  final String error;

  CashedSavedError(this.error);
}

class CashedGetError extends CashedState {
  final String error;

  CashedGetError(this.error);
}

class CashedGetSuccess extends CashedState {
  final dynamic value;

  CashedGetSuccess(this.value);
}
