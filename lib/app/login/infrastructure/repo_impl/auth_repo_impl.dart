import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:driver_project/app/login/domain/entities/user_param.dart';
import 'package:driver_project/app/login/domain/repo/auth_repo.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/auth_local.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/reactive_token_storage.dart';
import 'package:driver_project/app/login/infrastructure/data_source/remote/auth_remote.dart';
import 'package:driver_project/app/login/infrastructure/model/auth_token_dio.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';
import 'package:driver_project/common/core/user/entities/user.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoImpl extends AuthRepository {
  final AuthRemote remote;
  final ReactiveTokenStorage reactiveTokenStorage;
  final AuthLocal storageService;

  AuthRepoImpl({
    required this.remote,
    required this.reactiveTokenStorage,
    required this.storageService,
  });

  @override
  Future<Either<String, User?>> login({required UserParam userParam}) async {
    return throwAppException(() async {
      final response = await remote.login(userParam: userParam);
      _saveUser(response!);
      return response;
    });
  }

  @override
  Future<bool> logout() async {
    await storageService.removeUser();
    await reactiveTokenStorage.delete();
    return await getIt<SharedPreferences>().clear();
  }

  _saveUser(User user) async {
    await reactiveTokenStorage.write(AuthTokenModel(accessToken: user.accessToken, refreshToken: user.refreshToken));
    print(reactiveTokenStorage.authStatus);
    storageService.setUser(user);
  }

  @override
  Stream<AuthStatus> get authStatusStream {
    print('rabiea ${reactiveTokenStorage.authStatus }');
    return reactiveTokenStorage.authenticationStatus;
  }
}
