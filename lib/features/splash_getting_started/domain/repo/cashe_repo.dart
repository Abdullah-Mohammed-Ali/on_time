import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class CasheRepo {
  @override
  Future<Either<Failure, dynamic>?> setCashedData(String key, value);
  Future<Either<Failure, dynamic>?> getCashedData(String key);
}
