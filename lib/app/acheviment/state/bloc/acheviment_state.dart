// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'acheviment_bloc.dart';

class AchevimentState {
  final Result<TaskModel> achevimentTasks;
  final Result<TaskModel> deliveredTasks;
  AchevimentState({
    this.achevimentTasks = const Result.init(),
    this.deliveredTasks = const Result.init(),
  });

  AchevimentState copyWith({
    Result<TaskModel>? achevimentTasks,
    Result<TaskModel>? deliveredTasks,
  }) {
    return AchevimentState(
      achevimentTasks: achevimentTasks ?? this.achevimentTasks,
      deliveredTasks: deliveredTasks ?? this.deliveredTasks,
    );
  }
}
