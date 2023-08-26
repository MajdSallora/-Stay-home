// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/app/task/domain/repo/task_repo.dart';
import 'package:driver_project/app/task/infrastructure/model/order_on_way.dart';
import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:either_dart/either.dart';

class TaskFacade {
  final TaskRepo remote;
  TaskFacade({
    required this.remote,
  });

  Future<Either<String, TaskModel>> getAllAsigned() async => await remote.getAllAsigned();
  Future<Either<String, OrderOnWay>> getOrderOnWay() => remote.getOrderOnWay();
}
