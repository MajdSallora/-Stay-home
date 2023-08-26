// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';

import 'package:driver_project/app/deliver_details/domain/deliver_detail_repo/deliver_detail_repo.dart';
import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/common/constant/src/enum.dart';

class DeliverDetailFacade {
  final DeliverDetailRepo remote;
  DeliverDetailFacade({
    required this.remote,
  });

  Future<Either<String, DeliverDetailModel>> getOrderById(String id, OrderType type) => remote.getOrderById(id, type);
  Future<Either<String, bool>> acceptOrder(String id) => remote.acceptOrder(id);
  Future<Either<String, bool>> completeOrder(String id) => remote.completeOrder(id);
  Future<Either<String, bool>> cancelOrder(String id, String cancelBy, String reason) => remote.cancelOrder(id, cancelBy, reason);
}
