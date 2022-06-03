import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/generated/l10n.dart';

// region EVENT
import 'package:todo_app/model/task.dart';
import 'package:todo_app/repository/task_repository.dart';
import 'package:todo_app/util/date_time_utils.dart';

abstract class HomeEvent {}

class LoadTasks extends HomeEvent {
  final bool? completed;

  LoadTasks({this.completed});
}

class AddTask extends HomeEvent {
  final Task task;

  AddTask(this.task);
}

class DeleteTask extends HomeEvent {
  final int taskId;

  DeleteTask(this.taskId);
}

class UpdateTask extends HomeEvent {
  final Task task;

  UpdateTask(this.task);
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
  final Map<String, List<Task>> mapTasks;

  TasksLoaded(this.mapTasks);
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
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<LoadTask>(_onLoadTask);
  }

  _onLoadTasks(LoadTasks event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      if (event.completed == null) {
        final tasks = await TaskRepository().getAll();
        final todayTasks = tasks.where((e) => e.dueDate.isToday()).toList();
        final tommorowTasks =
            tasks.where((e) => e.dueDate.isTomorrow()).toList();
        final weekTasks = tasks
            .where((e) =>
                e.dueDate.inThisWeek() &&
                !e.dueDate.isToday() &&
                !e.dueDate.isTomorrow())
            .toList();
        emit(TasksLoaded({
          S.current.today: todayTasks,
          S.current.tommorow: tommorowTasks,
          S.current.this_week: weekTasks,
        }));
      } else if (event.completed == true) {
        final tasks = await TaskRepository().getCompletedTasks();
        final onTimeTasks = tasks.where((e) => !e.isOverdue).toList();
        final overdueTasks = tasks.where((e) => e.isOverdue).toList();
        emit(TasksLoaded({
          S.current.on_time: onTimeTasks,
          S.current.overdue: overdueTasks,
        }));
      } else {
        final tasks = await TaskRepository().getIncompletedTasks();
        final overdueTasks = tasks.where((e) => e.isOverdue).toList();
        final todayTasks = tasks.where((e) => e.dueDate.isToday()).toList();
        final tommorowTasks =
            tasks.where((e) => e.dueDate.isTomorrow()).toList();
        final weekTasks = tasks
            .where((e) =>
                e.dueDate.inThisWeek() &&
                !e.dueDate.isToday() &&
                !e.dueDate.isTomorrow())
            .toList();
        final otherTasks = tasks.where((e) => !e.dueDate.inThisWeek()).toList();
        emit(TasksLoaded({
          S.current.overdue: overdueTasks,
          S.current.today: todayTasks,
          S.current.tommorow: tommorowTasks,
          S.current.this_week: weekTasks,
          S.current.others: otherTasks,
        }));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  _onAddTask(AddTask event, Emitter<HomeState> emit) async {
    try {
      final ok = await TaskRepository().addTask(event.task);
      if (ok) {
        emit(TaskAdded());
      } else {
        throw Exception(S.current.duplicate_task);
      }
    } catch (e) {
      emit(HomeError('$e'));
    }
  }

  _onDeleteTask(DeleteTask event, Emitter<HomeState> emit) async {
    try {
      final ok = await TaskRepository().deleteTask(event.taskId);
      if (ok) {
        emit(TaskDeleted());
      } else {
        throw Exception(S.current.delete_task_error);
      }
    } catch (e) {
      emit(HomeError('$e'));
    }
  }

  _onUpdateTask(UpdateTask event, Emitter<HomeState> emit) async {
    try {
      final ok = await TaskRepository().updateTask(event.task);
      if (ok) {
        emit(TaskUpdated());
      } else {
        throw Exception(S.current.update_task_error);
      }
    } catch (e) {
      emit(HomeError('$e'));
    }
  }

  _onLoadTask(LoadTask event, Emitter<HomeState> emit) async {
    try {
      final task = await TaskRepository().getById(event.taskId);
      if (task == null) {
        throw Exception(S.current.task_not_found);
      } else {
        emit(TaskLoaded(task));
      }
    } catch (e) {
      emit(HomeError('$e'));
    }
  }
}
