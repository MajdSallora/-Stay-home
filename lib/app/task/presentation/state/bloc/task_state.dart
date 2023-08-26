// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

class TaskState {
  final Result<TaskModel> assignedTasks;
  final Result<OrderOnWay> deliverTask;
  TaskState({
    this.assignedTasks = const Result.init(),
    this.deliverTask = const Result.init(),
  });  

  TaskState copyWith({
    Result<TaskModel>? assignedTasks,
    Result<OrderOnWay>? deliverTask,
  }) {
    return TaskState(
      assignedTasks: assignedTasks ?? this.assignedTasks,
      deliverTask: deliverTask ?? this.deliverTask,
    );
  }
}
