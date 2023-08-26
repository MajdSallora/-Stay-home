// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;
  Login({
    required this.email,
    required this.password,
  });
}
