import 'package:bloc/bloc.dart';
import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/app/task/application/task_facade.dart';
import 'package:driver_project/app/task/infrastructure/model/order_on_way.dart';
import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:driver_project/common/core/result_builder/result.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskFacade _facade;

  TaskBloc({required TaskFacade facade})
      : _facade = facade,
        super(TaskState()) {
    on<TaskEvent>((event, emit) async {
      if (event is GetAllAsigned) {
        await getAllAsigned(event, emit);
      } else if (event is GetDeliveredOrder) {
        await getDeliveredOrder(event, emit);
      }
    });
  }

  getAllAsigned(GetAllAsigned event, Emitter<TaskState> emit) async {
    emit(state.copyWith(assignedTasks: const Result.loading()));
    final result = await _facade.getAllAsigned();
    result.fold(
      (left) => emit(state.copyWith(assignedTasks: Result.error(error: left))),
      (right) => emit(state.copyWith(assignedTasks: Result.loaded(data: right))),
    );
  }

  getDeliveredOrder(GetDeliveredOrder event, Emitter<TaskState> emit) async {
    emit(state.copyWith(deliverTask: const Result.loading()));
    final result = await _facade.getOrderOnWay();
    result.fold(
      (left) => emit(state.copyWith(deliverTask: Result.error(error: left))),
      (right) => emit(state.copyWith(deliverTask: Result.loaded(data: right))),
    );
  }
}
