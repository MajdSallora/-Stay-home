import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/common/constant/src/enum.dart';
import 'package:either_dart/either.dart';

abstract class DeliverDetailRepo {
  Future<Either<String, DeliverDetailModel>> getOrderById(String id, OrderType type);
  Future<Either<String, bool>> acceptOrder(String id);
  Future<Either<String, bool>> cancelOrder(String id, String cancelBy, String reason);
  Future<Either<String, bool>> completeOrder(String id);
}
