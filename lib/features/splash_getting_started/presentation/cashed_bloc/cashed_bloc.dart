import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/use_cases/cashe_use_case.dart';
import '../../domain/use_cases/save_cashe_use_case.dart';

part 'cashed_event.dart';
part 'cashed_state.dart';

class CashedBloc extends Bloc<CashedEvent, CashedState> {
  final SaveCasheUseCase _saveCasheUseCase;
  final GetCasheUseCase _getCasheUseCase;
  static CashedBloc get(context) => BlocProvider.of(context);

  CashedBloc(this._saveCasheUseCase, this._getCasheUseCase)
      : super(CashedInitial()) {
    on<CashedEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetDataEvent) {
        GetCasheParams getCasheParams = GetCasheParams(event.key);
        final result = await _getCasheUseCase(getCasheParams);
        result!.fold((l) {
          emit(CashedGetError(l.toString()));
        }, (r) {
          emit(
            CashedGetSuccess(r),
          );
        });
      } else if (event is SaveDataEvent) {
        SavedCasheParams savedCasheParams =
            SavedCasheParams(event.key, event.value);
        final result = await _saveCasheUseCase(savedCasheParams);
        result!.fold((l) => emit(CashedGetError(l.toString())),
            (r) => emit(CashedSavedSuccess(r)));
      }
    });
  }
}
