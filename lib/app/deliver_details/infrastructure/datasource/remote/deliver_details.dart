// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/common/constant/src/enum.dart';
import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';

class DeliverDetailsRemote {
  final Dio dio;
  DeliverDetailsRemote({
    required this.dio,
  });

  Future<DeliverDetailModel> getOrderById(String id, OrderType type) async {
    return throwDioException(() async {
      final response = await dio.get(
        getOrderIdUrl(type),
        queryParameters: {
          'Id': id,
        },
      );
      return DeliverDetailModel.fromMap(response.data['response']);
    });
  }

  Future<bool> complete(String id) {
    return throwDioException(() async {
      await dio.post(
        AppUrl.complete,
        queryParameters: {
          'id': id,
        },
      );
      return true;
    });
  }

  Future<bool> cancel(String id, String canelBy, reason) {
    return throwDioException(() async {
      await dio.post(
        AppUrl.cancel,
        queryParameters: {
          'id': id,
          'cancelBy': canelBy,
          'reason': reason,
        },
      );
      return true;
    });
  }

  Future<bool> accept(String id,) {
    return throwDioException(() async {
      await dio.post(
        AppUrl.accept,
        queryParameters: {
          'id': id,
        },
      );
      return true;
    });
  }

  String getOrderIdUrl(OrderType type) {
    switch (type) {
      case OrderType.delivery:
        return AppUrl.getByIdDeliveryOrder;
      case OrderType.passenger:
        return AppUrl.getByIdPassengerOrder;
      case OrderType.shipping:
        return AppUrl.getByIdShippingOrder;
    }
  }
}
