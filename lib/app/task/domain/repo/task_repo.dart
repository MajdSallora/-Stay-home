import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/app/task/infrastructure/model/order_on_way.dart';
import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:either_dart/either.dart';

abstract class TaskRepo {
  Future<Either<String, TaskModel>> getAllAsigned();
  Future<Either<String, OrderOnWay>> getOrderOnWay();
}
