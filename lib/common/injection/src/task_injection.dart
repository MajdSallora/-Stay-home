import 'package:dio/dio.dart';
import 'package:driver_project/app/task/application/task_facade.dart';
import 'package:driver_project/app/task/domain/repo/task_repo.dart';
import 'package:driver_project/app/task/infrastructure/data_source/remote/task_remote.dart';
import 'package:driver_project/app/task/infrastructure/task_repo_impl/task_repo_impl.dart';
import 'package:driver_project/app/task/presentation/state/bloc/task_bloc.dart';
import 'package:driver_project/common/injection/injection.dart';

taskInjection() {
  getIt.registerSingleton<TaskRemote>(
    TaskRemote(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerSingleton<TaskRepo>(
    TaskRepoImpl(
      remote: getIt<TaskRemote>(),
    ),
  );

  getIt.registerSingleton<TaskFacade>(
    TaskFacade(
      remote: getIt<TaskRepo>(),
    ),
  );

  getIt.registerFactory(
    () => TaskBloc(
      facade: getIt<TaskFacade>(),
    ),
  );
}
