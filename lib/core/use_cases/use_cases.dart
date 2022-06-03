import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';

abstract class UseCases<Type, Params> {
  Future<Either<Failure, Type>?> call(Params params) async {}
}
