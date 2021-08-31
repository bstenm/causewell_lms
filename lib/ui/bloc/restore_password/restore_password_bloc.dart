import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:causewell/data/repository/auth_repository.dart';
import 'package:causewell/ui/bloc/restore_password/bloc.dart';

@provide
class RestorePasswordBloc
    extends Bloc<RestorePasswordEvent, RestorePasswordState> {
  final AuthRepository _authRepository;

  RestorePasswordBloc(this._authRepository);

  @override
  RestorePasswordState get initialState => InitialRestorePasswordState();

  @override
  Stream<RestorePasswordState> mapEventToState(
      RestorePasswordEvent event) async* {
    if (event is SendRestorePasswordEvent) {
      try {
        yield LoadingRestorePasswordState();
        await _authRepository.restorePassword(event.email);
        yield SuccessRestorePasswordState();
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
  }
}
