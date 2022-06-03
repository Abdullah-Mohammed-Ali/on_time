import 'package:dartz/dartz.dart';
import 'package:on_time/core/errors/failure.dart';
import 'package:on_time/core/use_cases/use_cases.dart';
import 'package:on_time/features/splash_getting_started/domain/repo/cashe_repo.dart';

class SaveCasheUseCase implements UseCases<dynamic, SavedCasheParams> {
  final CasheRepo _casheRepo;

  SaveCasheUseCase(this._casheRepo);
  @override
  Future<Either<Failure, dynamic>?> call(savedCasheParams) {
    return _casheRepo.setCashedData(
        savedCasheParams.key, savedCasheParams.value);
  }
}

class SavedCasheParams {
  final String key;
  final dynamic value;

  SavedCasheParams(this.key, this.value);
}
