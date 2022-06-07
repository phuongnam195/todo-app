import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/setting.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/repository/task_repository.dart';
import 'package:todo_app/util/service_utils.dart';

// region EVENT
abstract class SplashEvent {}

class InitData extends SplashEvent {}
// endregion

// region STATE
abstract class SplashState {}

class SplashLoading extends SplashState {}

class DataInitialized extends SplashState {}

// endregion

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoading()) {
    on<InitData>(_onInitData);
  }

  _onInitData(InitData event, Emitter<SplashState> emit) async {
    await Setting().init();
    await S.load(Locale(Setting().getLanguage()));
    await ServiceUtils.run();
    await TaskRepository().init();
    emit(DataInitialized());
  }
}
