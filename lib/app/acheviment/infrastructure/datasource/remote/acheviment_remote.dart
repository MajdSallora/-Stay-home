import 'package:dio/dio.dart';
import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';

class AchevimentRemote {
  final Dio _dio;
  AchevimentRemote({
    required Dio dio,
  }) : _dio = dio;

  Future<TaskModel> getAllAcheviment() async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getAllEvaluated);
      return TaskModel.fromMap(response.data['response']);
    });
  }

  Future<TaskModel> getAllDelivered() async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getAllDelivered);
      return TaskModel.fromMap(response.data['response']);
    });
  }
}