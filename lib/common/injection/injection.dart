import 'package:driver_project/common/injection/src/acheviment_injection.dart';
import 'package:driver_project/common/injection/src/auth_injection.dart';
import 'package:driver_project/common/injection/src/deliver_detail.dart';
import 'package:driver_project/common/injection/src/general_injection.dart';
import 'package:driver_project/common/injection/src/profile_injection.dart';
import 'package:driver_project/common/injection/src/task_injection.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> initInjection() async {
  await generalInjection();
  await authInjection();
  profileInjection();
  taskInjection();
  deliverDetail();
  achevimentInjection();
}
