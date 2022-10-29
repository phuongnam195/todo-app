import 'package:flutter_bloc/flutter_bloc.dart';

// region EVENT
import 'package:todo_app/model/task.dart';
import 'package:todo_app/repository/task_repository.dart';
import 'package:todo_app/util/date_time_utils.dart';
import 'package:todo_app/util/logger.dart';

abstract class HomeEvent {}

class LoadTasks extends HomeEvent {
  final String? keyword;

  LoadTasks([this.keyword]);
}

class CheckTask extends HomeEvent {
  final Task task;

  CheckTask(this.task);
}

class AddTask extends HomeEvent {
  final Task task;

  AddTask(this.task);
}

class DeleteTask extends HomeEvent {
  final int taskId;

  DeleteTask(this.taskId);
}

class LoadTask extends HomeEvent {
  final int taskId;

  LoadTask(this.taskId);
}

// endregion

// region STATE
abstract class HomeState {}

class HomeLoading extends HomeState {}

class TasksLoaded extends HomeState {
  final List<Task> allTasks;
  final List<Task> todayTasks;
  final List<Task> upcomingTasks;

  TasksLoaded(this.allTasks, this.todayTasks, this.upcomingTasks);
}

class TaskAdded extends HomeState {}

class TaskDeleted extends HomeState {}

class TaskUpdated extends HomeState {}

class TaskLoaded extends HomeState {
  final Task task;

  TaskLoaded(this.task);
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
// endregion

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<CheckTask>(_onCheckTask);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<LoadTask>(_onLoadTask);
  }

  _onLoadTasks(LoadTasks event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final allTasks = event.keyword == null
          ? await TaskRepository().getAll()
          : await TaskRepository().getAllBySearch(event.keyword!);
      final todayTasks = allTasks.where((e) => e.dueDate.isToday()).toList();
      final upcomingTasks = allTasks
          .where((e) =>
              e.dueDate.isAfter(DateTimeUtils.tomorrow()) ||
              e.dueDate.isAtSameMomentAs(DateTimeUtils.tomorrow()))
          .toList();
      emit(TasksLoaded(allTasks, todayTasks, upcomingTasks));
    } catch (e) {
      emit(HomeError(e.toString()));
      Logger.e('HomeBloc -> LoadTasks', e);
    }
  }

  _onCheckTask(CheckTask event, Emitter<HomeState> emit) async {
    try {
      final ok = await TaskRepository().updateTask(event.task);
      if (!ok) {
        throw Exception('Cannot update this task!');
      }
    } catch (e) {
      emit(HomeError('$e'));
      Logger.e('HomeBloc -> CheckTask', e);
    }
  }

  _onAddTask(AddTask event, Emitter<HomeState> emit) async {
    try {
      final ok = await TaskRepository().addTask(event.task);
      if (ok) {
        emit(TaskAdded());
      } else {
        throw Exception('Duplicate task');
      }
    } catch (e) {
      emit(HomeError('$e'));
      Logger.e('HomeBloc -> AddTask', e);
    }
  }

  _onDeleteTask(DeleteTask event, Emitter<HomeState> emit) async {
    try {
      final ok = await TaskRepository().deleteTask(event.taskId);
      if (ok) {
        emit(TaskDeleted());
      } else {
        throw Exception('Task does not exist');
      }
    } catch (e) {
      emit(HomeError('$e'));
      Logger.e('HomeBloc -> DeleteTask', e);
    }
  }

  _onLoadTask(LoadTask event, Emitter<HomeState> emit) async {
    try {
      final task = await TaskRepository().getById(event.taskId);
      if (task == null) {
        throw Exception('Task not found');
      } else {
        emit(TaskLoaded(task));
      }
    } catch (e) {
      emit(HomeError('$e'));
      Logger.e('HomeBloc -> LoadTask', e);
    }
  }
}
