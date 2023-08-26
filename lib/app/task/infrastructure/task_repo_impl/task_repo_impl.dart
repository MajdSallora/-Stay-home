// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/app/task/domain/repo/task_repo.dart';
import 'package:driver_project/app/task/infrastructure/data_source/remote/task_remote.dart';
import 'package:driver_project/app/task/infrastructure/model/order_on_way.dart';
import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';
import 'package:either_dart/src/either.dart';

class TaskRepoImpl extends TaskRepo {
  final TaskRemote remote;
  TaskRepoImpl({
    required this.remote,
  });

  @override
  Future<Either<String, TaskModel>> getAllAsigned() async {
    return throwAppException(() async {
      final response = await remote.getAllAssigned();
      return response;
    });
  }

  @override
  Future<Either<String, OrderOnWay>> getOrderOnWay() {
    return throwAppException(() async {
      final response = await remote.getOrderOnWay();
      return response;
    });
  }
}
