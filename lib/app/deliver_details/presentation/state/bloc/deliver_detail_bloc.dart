import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:driver_project/app/deliver_details/application/facade/deliver_detail_facade.dart';
import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/common/constant/src/enum.dart';
import 'package:driver_project/common/core/result_builder/result.dart';

part 'deliver_detail_event.dart';
part 'deliver_detail_state.dart';

class DeliverDetailBloc extends Bloc<DeliverDetailEvent, DeliverDetailState> {
  final DeliverDetailFacade _facade;

  DeliverDetailBloc({required DeliverDetailFacade facade})
      : _facade = facade,
        super(DeliverDetailState()) {
    on<DeliverDetailEvent>((event, emit) async {
      if (event is GetOrderById) {
        await getOrderById(event, emit);
      } else if (event is CancelOrder) {
        await cancelOrder(event, emit);
      } else if (event is AcceptOrder) {
        await acceptOrder(event, emit);
      } else if (event is CompleteOrder) {
        await completeOrder(event, emit);
      }
    });
  }

  getOrderById(GetOrderById event, Emitter<DeliverDetailState> emit) async {
    emit(state.copyWith(order: const Result.loading()));
    final result = await _facade.getOrderById(event.id, event.type);
    result.fold(
      (left) => emit(state.copyWith(order: Result.error(error: left))),
      (right) => emit(state.copyWith(order: Result.loaded(data: right))),
    );
  }

  cancelOrder(CancelOrder event, Emitter<DeliverDetailState> emit) async {
    BotToast.showLoading();
    final result = await _facade.cancelOrder(event.id, event.cancelBy, event.reason);
    result.fold(
      (left) => BotToast.showText(text: left),
      (right) => BotToast.showText(text: 'تم إلغاء الرحلة بنجاح'),
    );
    BotToast.closeAllLoading();
  }

  acceptOrder(AcceptOrder event, Emitter<DeliverDetailState> emit) async {
    BotToast.showLoading();
    final result = await _facade.acceptOrder(event.id);
    result.fold(
      (left) => BotToast.showText(text: left),
      (right) => BotToast.showText(text: 'تم قبول الرحلة بنجاح'),
    );
    BotToast.closeAllLoading();
  }

  completeOrder(CompleteOrder event, Emitter<DeliverDetailState> emit) async {
    BotToast.showLoading();
    final result = await _facade.completeOrder(event.id);
    result.fold(
      (left) => BotToast.showText(text: left),
      (right) => BotToast.showText(text: 'تم إنهاء الرحلة بنجاح'),
    );
    BotToast.closeAllLoading();
  }
}
