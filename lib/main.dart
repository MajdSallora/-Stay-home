import 'package:bot_toast/bot_toast.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/auth_local.dart';
import 'package:driver_project/app/login/infrastructure/repo_impl/auth_repo_impl.dart';
import 'package:driver_project/app/login/presentation/state/app_manager_bloc/app_manager_bloc.dart';
import 'package:driver_project/app/root/presentation/screen/root.dart';
import 'package:driver_project/common/imports/imports.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'app/on_boarding/on_boarding.dart';
import 'common/const/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppManagerBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = AppManagerBloc(lazyAuthRepository: () => getIt<AuthRepoImpl>(), context: context)..add(AppManagerStarted());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) {
          print(_bloc.state.status);
          return MultiProvider(
            providers: [
              BlocProvider.value(value: _bloc),
            ],
            child: Builder(builder: (context) {
              return MaterialApp(
                title: 'Stay Home',
                theme: lightTheme,
                home: getIt<AuthLocal>().getUser() != null
                    ? const RootScreen()
                    : const Directionality(textDirection: TextDirection.rtl, child: OnBoarding()),
                builder: (context, child) {
                  return BotToastInit()(
                    context,
                    child,
                  );
                },
              );
            }),
          );
        });
  }
}
