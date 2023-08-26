import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:driver_project/app/login/domain/entities/user_param.dart';
import 'package:driver_project/common/core/user/entities/user.dart';
import 'package:either_dart/either.dart';

abstract class AuthRepository {
  AuthRepository();

  Stream<AuthStatus> get authStatusStream;

  Future<Either<String, User?>> login({
    required UserParam userParam,
  });

  Future<bool> logout();
}