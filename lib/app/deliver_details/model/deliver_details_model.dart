// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:driver_project/app/deliver_details/model/cart_model.dart';

class DeliverDetailModel {
  final String id;
  final String customer;
  final DateTime date;
  final double coast;
  final String source;
  final String destination;
  final String? note;
  final double? weight;
  final List<CartModel>? cartModel;
  final int? numberOfPassenger;
  final double distance;
  DeliverDetailModel({
    required this.id,
    required this.customer,
    required this.date,
    required this.coast,
    required this.source,
    required this.destination,
    required this.distance,
    this.note,
    this.weight,
    this.cartModel,
    this.numberOfPassenger,
  });

  factory DeliverDetailModel.fromMap(Map<String, dynamic> map) {
    return DeliverDetailModel(
      id: map['id'] as String,
      customer: map['customer'] as String,
      date: DateTime.parse(map['date']),
      coast: double.parse('${map['coast']}'),
      source: map['source'] as String,
      destination: map['destination'] as String,
      distance: double.parse('${map['distance']}'),
      note: map['note'] != null ? map['note'] as String : null,
      weight: map['weight'] != null ? double.parse('${map['weight']}') : null,
      cartModel: map['cart'] != null
          ? (map['cart'] as List)
              .map(
                (e) => CartModel.fromMap(e),
              )
              .toList()
          : null,
      numberOfPassenger: map['numberOfPassenger'] != null ? map['numberOfPassenger'] as int : null,
    );
  }
}
