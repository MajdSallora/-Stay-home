import 'package:dio/dio.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/reactive_token_storage.dart';
import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/core/network/dio_client.dart';
import 'package:driver_project/common/core/utils/storage_service.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> generalInjection() async {
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<StorageService<SharedStorage>>(StorageService.shared(getIt<SharedPreferences>()));

  getIt.registerSingleton<ReactiveTokenStorage>(ReactiveTokenStorage(getIt<StorageService<SharedStorage>>()));


  getIt.registerSingleton<Dio>(
    DioClient("${AppUrl.baseUrl}/api/Driver/"),
  );
}