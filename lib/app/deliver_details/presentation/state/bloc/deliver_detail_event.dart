// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'deliver_detail_bloc.dart';

abstract class DeliverDetailEvent {}

class GetOrderById extends DeliverDetailEvent {
  final String id;
  final OrderType type;
  GetOrderById({
    required this.id,
    required this.type,
  });
}

class CompleteOrder extends DeliverDetailEvent {
  final String id;
  CompleteOrder({
    required this.id,
  });
}

class CancelOrder extends DeliverDetailEvent {
  final String id;
  final String cancelBy;
  final String reason;
  CancelOrder({
    required this.id,
    required this.cancelBy,
    required this.reason,
  });
}

class AcceptOrder extends DeliverDetailEvent {
  final String id;
  AcceptOrder({
    required this.id,
  });
}
