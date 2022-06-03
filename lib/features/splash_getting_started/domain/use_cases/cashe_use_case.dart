import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';

import '../repo/cashe_repo.dart';

class GetCasheUseCase implements UseCases<dynamic, GetCasheParams> {
  final CasheRepo _cashedRepoImpl;

  GetCasheUseCase(this._cashedRepoImpl);
  @override
  Future<Either<Failure, dynamic>?> call(params) {
    return _cashedRepoImpl.getCashedData(params.key);
  }
}

class GetCasheParams {
  final String key;

  GetCasheParams(this.key);
}
