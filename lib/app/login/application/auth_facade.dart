import 'package:driver_project/app/login/domain/entities/user_param.dart';
import 'package:driver_project/app/login/infrastructure/repo_impl/auth_repo_impl.dart';
import 'package:either_dart/either.dart';

import '../../../common/core/user/entities/user.dart';

class AuthFacade {
  final AuthRepoImpl _repoImpl;

  AuthFacade({required AuthRepoImpl authRepoImpl}) : _repoImpl = authRepoImpl;

  Future<Either<String, User?>> login(UserParam userParam) async => await _repoImpl.login(userParam: userParam);
}