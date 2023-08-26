// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:driver_project/app/acheviment/domain/repo/acheviment_repo.dart';
import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:either_dart/either.dart';

class AchevimentFacade {
  final AchevimentRepo remote;
  AchevimentFacade({
    required this.remote,
  });

  Future<Either<String, TaskModel>> getAllAcheviment() => remote.getAllAcheviment();
  Future<Either<String, TaskModel>> getAllDelivered() => remote.getAllDelivered();
}
