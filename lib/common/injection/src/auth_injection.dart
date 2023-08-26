import 'package:dio/dio.dart';
import 'package:driver_project/app/login/application/auth_facade.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/auth_local.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/reactive_token_storage.dart';
import 'package:driver_project/app/login/infrastructure/data_source/remote/auth_remote.dart';
import 'package:driver_project/app/login/infrastructure/repo_impl/auth_repo_impl.dart';
import 'package:driver_project/app/login/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:driver_project/common/core/utils/storage_service.dart';
import 'package:driver_project/common/injection/injection.dart';

authInjection() {
  getIt.registerSingleton<AuthLocal>(AuthLocal(local: getIt<StorageService<SharedStorage>>()));

  // remote
  getIt.registerSingleton<AuthRemote>(
    AuthRemote(getIt<Dio>()),
  );

  // repo
  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      remote: getIt<AuthRemote>(),
      reactiveTokenStorage: getIt<ReactiveTokenStorage>(),
      storageService: getIt<AuthLocal>(),
    ),
  );

  // application
  getIt.registerSingleton<AuthFacade>(
    AuthFacade(
      authRepoImpl: getIt<AuthRepoImpl>(),
    ),
  );

  //bloc
  getIt.registerFactory(
    () => AuthBloc(
      facade: getIt<AuthFacade>(),
    ),
  );
}
