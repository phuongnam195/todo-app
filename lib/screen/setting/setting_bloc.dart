import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/setting.dart';
import 'package:todo_app/generated/l10n.dart';

// region EVENT
abstract class SettingEvent {}

class LoadSetting extends SettingEvent {}

class SwitchLanguage extends SettingEvent {}

class ToggleNotification extends SettingEvent {}
// endregion

// region STATE
abstract class SettingState {}

class SettingLoaded extends SettingState {
  final String languageCode;
  final bool notification;

  SettingLoaded(this.languageCode, this.notification);
}
// endregion

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(SettingLoaded(
            Setting().getLanguage(), Setting().getNotification())) {
    on<LoadSetting>(_onLoadSetting);
    on<SwitchLanguage>(_onSwitchLanguage);
    on<ToggleNotification>(_onToggleNotification);
  }

  _onLoadSetting(LoadSetting event, Emitter<SettingState> emit) {
    final languageCode = Setting().getLanguage();
    final notification = Setting().getNotification();
    emit(SettingLoaded(languageCode, notification));
  }

  _onSwitchLanguage(SwitchLanguage event, Emitter<SettingState> emit) {
    if (Setting().getLanguage() == 'en') {
      S.load(const Locale('vi'));
      Setting().setLanguage('vi');
    } else {
      S.load(const Locale('en'));
      Setting().setLanguage('en');
    }
    add(LoadSetting());
  }

  _onToggleNotification(ToggleNotification event, Emitter<SettingState> emit) {
    // TODO: implement

    if (Setting().getNotification() == true) {
      Setting().setNotification(false);
    } else {
      Setting().setNotification(true);
    }
    add(LoadSetting());
  }
}
