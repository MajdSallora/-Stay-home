
import 'package:dio/dio.dart';
import 'package:driver_project/app/acheviment/application/facade/acheviment_facade.dart';
import 'package:driver_project/app/acheviment/domain/repo/acheviment_repo.dart';
import 'package:driver_project/app/acheviment/infrastructure/datasource/remote/acheviment_remote.dart';
import 'package:driver_project/app/acheviment/infrastructure/repo_impl/acheviment_repo_impl.dart';
import 'package:driver_project/app/acheviment/state/bloc/acheviment_bloc.dart';
import 'package:driver_project/common/injection/injection.dart';

achevimentInjection() {
  getIt.registerSingleton<AchevimentRemote>(
    AchevimentRemote(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerSingleton<AchevimentRepo>(
    AchevimentRepoImpl(
      remote: getIt<AchevimentRemote>(),
    ),
  );

  getIt.registerSingleton<AchevimentFacade>(
    AchevimentFacade(
      remote: getIt<AchevimentRepo>(),
    ),
  );

  getIt.registerFactory(
    () => AchevimentBloc(
      facade: getIt<AchevimentFacade>(),
    ),
  );
}
