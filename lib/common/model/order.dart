// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:driver_project/common/constant/src/enum.dart';

class OrderModel {
  final String id;
  final String customer;
  final DateTime date;
  final double coast;
  final String source;
  final String destination;
  final OrderType type;
  final int? star;
  final bool? isEvaluated;

  OrderModel({
    required this.id,
    required this.customer,
    required this.date,
    required this.coast,
    required this.source,
    required this.destination,
    required this.type,
    this.star,
    this.isEvaluated,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customer': customer,
      'date': date.toIso8601String(),
      'coast': coast,
      'source': source,
      'destination': destination,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      customer: map['customer'] as String,
      date: DateTime.parse(map['date']),
      coast: double.parse('${map['coast']}'),
      source: map['source'] as String,
      destination: map['destination'] as String,
      type: map['type'] as OrderType,
      star: map['star'],
      isEvaluated: map['isEvaluated'],
    );
  }
}
