import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:either_dart/either.dart';

abstract class AchevimentRepo {
  Future<Either<String, TaskModel>> getAllAcheviment();
  Future<Either<String, TaskModel>> getAllDelivered();
}
