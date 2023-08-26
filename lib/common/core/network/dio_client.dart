import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer2/dio_flutter_transformer2.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/auth_local.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/reactive_token_storage.dart';
import 'package:driver_project/app/login/infrastructure/model/auth_token_dio.dart';
import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/core/network/error_interceptor.dart';
import 'package:driver_project/common/core/utils/storage_service.dart';
import 'package:driver_project/common/imports/imports.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:flutter/foundation.dart';

class DioClient with DioMixin implements Dio {
  late final local;

  DioClient(
    this.baseUrl, {
    List<Interceptor> interceptors = const [],
  }) {
    local = getIt<StorageService<SharedStorage>>();
    options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
    );
    transformer = FlutterTransformer();
    httpClientAdapter = DefaultHttpClientAdapter();
    options
      ..baseUrl = baseUrl
      ..headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Transfer-Encoding": "chunked"
      };
    if (interceptors.isNotEmpty) {
      this.interceptors.addAll(interceptors);
    }
    final logInterceptor = LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true,
    );
    final tokenDio = Dio(options)
      ..interceptors.addAll([
        logInterceptor,
      ]);
    this.interceptors.addAll([
      RefreshTokenInterceptor<AuthTokenModel>(
        debugLog: true,
        tokenProtocol: TokenProtocol(
          shouldRefresh: (response, token) {
            printR('shouldRefresh');
            return response?.statusCode == 401;
          },
        ),
        // onRevoked: (dioError) {
        //   if (dioError.response!.statusCode == 403) {
        //     getIt<AuthRepository>().logout();
        //   }
        //   throw dioError;
        // },
        tokenStorage: getIt<ReactiveTokenStorage>(),
        tokenDio: tokenDio,
        refreshToken: (token, tokenDio) async {
          print('refresh');
          final response = await tokenDio.post('${AppUrl.baseUrl}api/${AppUrl.refreshToken}', queryParameters: {
            'id': getIt<AuthLocal>().getUser()!.id,
            'refreshToken': token.refreshToken,
          });
          final authTokenModel = AuthTokenModel.fromMap(response.data);
          final authTokenModel2 = AuthTokenModel(
            accessToken: authTokenModel.accessToken,
            refreshToken: authTokenModel.refreshToken ?? token.refreshToken,
          );
          return authTokenModel2;
        },
      ),
      if (!kReleaseMode) logInterceptor,
      ErrorInterceptor(),
    ]);
  }

  final String baseUrl;
}
