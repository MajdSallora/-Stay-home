// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/src/either.dart';

import 'package:driver_project/app/deliver_details/domain/deliver_detail_repo/deliver_detail_repo.dart';
import 'package:driver_project/app/deliver_details/infrastructure/datasource/remote/deliver_details.dart';
import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/common/constant/src/enum.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';

class DeliverDetailRepoImpl extends DeliverDetailRepo {
  final DeliverDetailsRemote remote;
  DeliverDetailRepoImpl({
    required this.remote,
  });

  @override
  Future<Either<String, DeliverDetailModel>> getOrderById(String id, OrderType type) {
    return throwAppException(() async {
      final response = await remote.getOrderById(id, type);
      return response;
    });
  }

  @override
  Future<Either<String, bool>> acceptOrder(String id) {
    return throwAppException(() async {
      final response = await remote.accept(id);
      return response;
    });
  }

  @override
  Future<Either<String, bool>> cancelOrder(String id, String cancelBy, String reason) {
    return throwAppException(() async {
      final response = await remote.cancel(id, cancelBy, reason);
      return response;
    });
  }

  @override
  Future<Either<String, bool>> completeOrder(String id) {
    return throwAppException(() async {
      final response = await remote.complete(id);
      return response;
    });
  }
}
