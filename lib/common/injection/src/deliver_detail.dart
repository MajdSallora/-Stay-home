import 'package:dio/dio.dart';
import 'package:driver_project/app/deliver_details/application/facade/deliver_detail_facade.dart';
import 'package:driver_project/app/deliver_details/domain/deliver_detail_repo/deliver_detail_repo.dart';
import 'package:driver_project/app/deliver_details/infrastructure/datasource/remote/deliver_details.dart';
import 'package:driver_project/app/deliver_details/infrastructure/repo/deliver_detail_repo_impl.dart';
import 'package:driver_project/app/deliver_details/presentation/state/bloc/deliver_detail_bloc.dart';
import 'package:driver_project/common/injection/injection.dart';

deliverDetail() {
  //remote
  getIt.registerSingleton<DeliverDetailsRemote>(
    DeliverDetailsRemote(
      dio: getIt<Dio>(),
    ),
  );

  //repo
  getIt.registerSingleton<DeliverDetailRepo>(
    DeliverDetailRepoImpl(
      remote: getIt<DeliverDetailsRemote>(),
    ),
  );

  //facade
  getIt.registerSingleton<DeliverDetailFacade>(
    DeliverDetailFacade(
      remote: getIt<DeliverDetailRepo>(),
    ),
  );

  //state
  getIt.registerFactory<DeliverDetailBloc>(
    () => DeliverDetailBloc(
      facade: getIt<DeliverDetailFacade>(),
    ),
  );
}
