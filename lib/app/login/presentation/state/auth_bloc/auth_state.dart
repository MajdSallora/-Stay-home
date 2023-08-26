part of 'auth_bloc.dart';

class AuthState {
  BlocStatus status;

  AuthState({
    this.status = const BlocStatus.initial(),
  });

  AuthState copyWith({
    BlocStatus? status,
  }) {
    return AuthState(
      status: status ?? this.status,
    );
  }
}
