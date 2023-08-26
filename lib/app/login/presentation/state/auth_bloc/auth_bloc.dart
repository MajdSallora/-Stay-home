import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:driver_project/app/login/application/auth_facade.dart';
import 'package:driver_project/app/login/domain/entities/user_param.dart';
import 'package:driver_project/common/helper/bloc_status.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthFacade _authFacade;

  AuthBloc({required AuthFacade facade})
      : _authFacade = facade,
        super(AuthState()) {
    on<AuthEvent>((event, emit) async {
      if (event is Login) {
        await login(event, emit);
      }
    });
  }

  login(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: const BlocStatus.loading()));
    BotToast.showLoading();
    final result = await _authFacade.login(
      UserParam(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (left) {
        emit(state.copyWith(status: BlocStatus.fail(error: left)));
        BotToast.showText(text: left);
      },
      (right) => emit(state.copyWith(status: const BlocStatus.success())),
    );
    BotToast.closeAllLoading();
  }
}
