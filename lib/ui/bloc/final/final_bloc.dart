import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:causewell/data/cache/cache_manager.dart';
import 'package:causewell/data/models/FinalResponse.dart';
import 'package:causewell/data/repository/final_repository.dart';

import './bloc.dart';

@provide
class FinalBloc extends Bloc<FinalEvent, FinalState> {
  final FinalRepository _finalRepository;
  final CacheManager cacheManager;

  FinalBloc(this._finalRepository, this.cacheManager);

  @override
  FinalState get initialState => InitialFinalState();

  @override
  Stream<FinalState> mapEventToState(FinalEvent event) async* {
    if (event is FetchEvent) {
      try {
        FinalResponse response =
            await _finalRepository.getCourseResults(event.courseId);

        print(response);

        yield LoadedFinalState(response);
      } catch (error) {
        if (await cacheManager.isCached(event.courseId)) {
          yield CacheWarningState();
        }
        print('Final Page Error');
        print(error);
      }
    }
  }
}
