import 'package:dio/dio.dart';
import 'package:driver_project/app/profile/application/profile_facade.dart';
import 'package:driver_project/app/profile/domain/profile_repo/profile_repo.dart';
import 'package:driver_project/app/profile/inrastructure/date_source/profile_remote.dart';
import 'package:driver_project/app/profile/inrastructure/repo/profile_repo_impl.dart';
import 'package:driver_project/app/profile/presentation/state/profile_bloc.dart';
import 'package:driver_project/common/injection/injection.dart';

profileInjection() {
  // remote
  getIt.registerSingleton<ProfileRemote>(
    ProfileRemote(
      dio: getIt<Dio>(),
    ),
  );

  // repo
  getIt.registerSingleton<ProfileRepo>(
    ProfileRepoImpl(
      remote: getIt<ProfileRemote>(),
    ),
  );

  // application
  getIt.registerSingleton<ProfileFacade>(
    ProfileFacade(
      remote: getIt<ProfileRepo>(),
    ),
  );

  //state
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(getIt<ProfileFacade>()));
}
