// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/app/task/infrastructure/model/order_on_way.dart';
import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';

class TaskRemote {
  final Dio _dio;
  TaskRemote({
    required Dio dio,
  }) : _dio = dio;

  Future<TaskModel> getAllAssigned() async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getAllAssigned);
      return TaskModel.fromMap(response.data['response']);
    });
  }

  Future<OrderOnWay> getOrderOnWay() async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getOrderOnWay);
      return OrderOnWay.fromMap(response.data['response']);
    });
  }
}
