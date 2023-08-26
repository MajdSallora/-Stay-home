// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';

class OrderOnWay {
  final DeliverDetailModel? shippingOrder;
  final DeliverDetailModel? deliveryOrder;
  final DeliverDetailModel? passengerOrder;
  OrderOnWay({
    this.shippingOrder,
    this.deliveryOrder,
    this.passengerOrder,
  });

  factory OrderOnWay.fromMap(Map<String, dynamic> map) {
    return OrderOnWay(
      shippingOrder: map['shippingOrder'] != null ? DeliverDetailModel.fromMap(map['shippingOrder'] as Map<String,dynamic>) : null,
      deliveryOrder: map['deliveryOrder'] != null ? DeliverDetailModel.fromMap(map['deliveryOrder'] as Map<String,dynamic>) : null,
      passengerOrder: map['passengerOrder'] != null ? DeliverDetailModel.fromMap(map['passengerOrder'] as Map<String,dynamic>) : null,
    );
  }
}
