// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'deliver_detail_bloc.dart';

class DeliverDetailState {
  final Result<DeliverDetailModel> order;
  DeliverDetailState({
    this.order = const Result.init(),
  });

  DeliverDetailState copyWith({
    Result<DeliverDetailModel>? order,
  }) {
    return DeliverDetailState(
      order: order ?? this.order,
    );
  }
}
