part of 'task_bloc.dart';

abstract class TaskEvent  {
  
}

class GetAllAsigned extends TaskEvent {}

class GetDeliveredOrder extends TaskEvent {}
