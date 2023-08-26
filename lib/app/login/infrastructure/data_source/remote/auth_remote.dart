import 'package:dio/dio.dart';
import 'package:driver_project/app/login/domain/entities/user_param.dart';
import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';
import 'package:driver_project/common/core/user/entities/user.dart';

class AuthRemote {
  final Dio _dio;

  const AuthRemote(Dio dio) : _dio = dio;

  Future<User?> login({required UserParam userParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.login,
        data: await userParam.toJson(),
      );
      return User.fromMap(response.data['response']);
    });
  }
}
