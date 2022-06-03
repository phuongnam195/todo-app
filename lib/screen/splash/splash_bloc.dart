import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/setting.dart';
import 'package:todo_app/generated/l10n.dart';

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
    S.load(Locale(Setting().getLanguage()));
    emit(DataInitialized());
  }
}
