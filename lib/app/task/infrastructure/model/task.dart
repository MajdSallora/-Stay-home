// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:driver_project/common/constant/src/enum.dart';
import 'package:driver_project/common/model/order.dart';

class TaskModel {
  final List<OrderModel> shippingOrder;
  final List<OrderModel> deliveryOrder;
  final List<OrderModel> passengerOrder;
  TaskModel({
    required this.shippingOrder,
    required this.deliveryOrder,
    required this.passengerOrder,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shippingOrder': shippingOrder.map((x) => x.toMap()).toList(),
      'deliveryOrder': deliveryOrder.map((x) => x.toMap()).toList(),
      'passengerOrder': passengerOrder.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      shippingOrder:
          (map['shippingOrder'] as List).map((e) => OrderModel.fromMap((e as Map<String, dynamic>)..addAll({'type': OrderType.shipping}))).toList(),
      deliveryOrder:
          (map['deliveryOrder'] as List).map((e) => OrderModel.fromMap((e as Map<String, dynamic>)..addAll({'type': OrderType.delivery}))).toList(),
      passengerOrder:
          (map['passengerOrder'] as List).map((e) => OrderModel.fromMap((e as Map<String, dynamic>)..addAll({'type': OrderType.passenger}))).toList(),
    );
  }
}
