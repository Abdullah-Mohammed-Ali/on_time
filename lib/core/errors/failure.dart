abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class CreateFailure extends Failure {
  CreateFailure(String errorMessage) : super(errorMessage);
}

class UpdateFailure extends Failure {
  UpdateFailure(String errorMessage) : super(errorMessage);
}

class DeleteFailure extends Failure {
  DeleteFailure(String errorMessage) : super(errorMessage);
}

class GetNoteFailure extends Failure {
  GetNoteFailure(String errorMessage) : super(errorMessage);
}

class GetNotesFailure extends Failure {
  GetNotesFailure(String errorMessage) : super(errorMessage);
}

class CashedFailure extends Failure {
  CashedFailure(String errorMessage) : super(errorMessage);
}

class CalendarFailure extends Failure {
  CalendarFailure(String errorMessage) : super(errorMessage);
}
