import 'package:driver_project/app/acheviment/domain/repo/acheviment_repo.dart';
import 'package:driver_project/app/acheviment/infrastructure/datasource/remote/acheviment_remote.dart';
import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';
import 'package:either_dart/src/either.dart';

class AchevimentRepoImpl extends AchevimentRepo {
  final AchevimentRemote remote;
  AchevimentRepoImpl({
    required this.remote,
  });

  @override
  Future<Either<String, TaskModel>> getAllAcheviment() {
    return throwAppException(() async {
      final response = await remote.getAllAcheviment();
      return response;
    });
  }

  @override
  Future<Either<String, TaskModel>> getAllDelivered() {
    return throwAppException(() async {
      final response = await remote.getAllDelivered();
      return response;
    });
  }
}
