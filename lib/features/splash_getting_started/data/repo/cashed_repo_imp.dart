import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';

import '../../domain/repo/cashe_repo.dart';
import '../data_source/data_source.dart';

class CashedRepoImpl implements CasheRepo {
  final CashedDataSource _cashedDataSource;

  CashedRepoImpl(this._cashedDataSource);
  @override
  Future<Either<Failure, dynamic>?> getCashedData(String key) async {
    try {
      final result = await _cashedDataSource.getData(key);
      return Right(result);
    } catch (e) {
      return Left(CashedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>?> setCashedData(String key, value) async {
    final result = await _cashedDataSource.setData(key, value);
    if (result) {
      return Right(result);
    } else {
      Left(CashedFailure('cashed error'));
    }
  }
}
