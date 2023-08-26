import 'package:bloc/bloc.dart';
import 'package:driver_project/app/acheviment/application/facade/acheviment_facade.dart';
import 'package:driver_project/app/task/infrastructure/model/task.dart';
import 'package:driver_project/common/core/result_builder/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'acheviment_event.dart';
part 'acheviment_state.dart';

class AchevimentBloc extends Bloc<AchevimentEvent, AchevimentState> {
  final AchevimentFacade _facade;

  AchevimentBloc({required AchevimentFacade facade})
      : _facade = facade,
        super(AchevimentState()) {
    on<AchevimentEvent>((event, emit) async {
      if (event is GetAllAcheviment) {
        await getAllAcheviment(event, emit);
      } else if(event is GetAllDelivered) {
        await getAllDelivered(event, emit);
      }
    });
  }
  
  getAllAcheviment(GetAllAcheviment event, Emitter<AchevimentState> emit) async {
    emit(state.copyWith(achevimentTasks: const Result.loading()));
    final result = await _facade.getAllAcheviment();
    result.fold(
      (left) => emit(state.copyWith(achevimentTasks: Result.error(error: left))),
      (right) => emit(state.copyWith(achevimentTasks: Result.loaded(data: right))),
    );
  }
  
  getAllDelivered(GetAllDelivered event, Emitter<AchevimentState> emit) async {
    emit(state.copyWith(deliveredTasks: const Result.loading()));
    final result = await _facade.getAllDelivered();
    result.fold(
      (left) => emit(state.copyWith(deliveredTasks: Result.error(error: left))),
      (right) => emit(state.copyWith(deliveredTasks: Result.loaded(data: right))),
    );
  }
}
