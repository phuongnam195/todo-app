// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Incomplete`
  String get incomplete {
    return Intl.message(
      'Incomplete',
      name: 'incomplete',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Tommorow`
  String get tommorow {
    return Intl.message(
      'Tommorow',
      name: 'tommorow',
      desc: '',
      args: [],
    );
  }

  /// `This week`
  String get this_week {
    return Intl.message(
      'This week',
      name: 'this_week',
      desc: '',
      args: [],
    );
  }

  /// `On time`
  String get on_time {
    return Intl.message(
      'On time',
      name: 'on_time',
      desc: '',
      args: [],
    );
  }

  /// `Overdue`
  String get overdue {
    return Intl.message(
      'Overdue',
      name: 'overdue',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task`
  String get delete_task {
    return Intl.message(
      'Delete Task',
      name: 'delete_task',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure delete this task?`
  String get delete_task_confirm {
    return Intl.message(
      'Are you sure delete this task?',
      name: 'delete_task_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Try typing 'Take the English test'`
  String get task_title_hint {
    return Intl.message(
      'Try typing \'Take the English test\'',
      name: 'task_title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Due date`
  String get due_date {
    return Intl.message(
      'Due date',
      name: 'due_date',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get repeat {
    return Intl.message(
      'Repeat',
      name: 'repeat',
      desc: '',
      args: [],
    );
  }

  /// `Add new task`
  String get add_new_task {
    return Intl.message(
      'Add new task',
      name: 'add_new_task',
      desc: '',
      args: [],
    );
  }

  /// `Task has been added!`
  String get add_task_success {
    return Intl.message(
      'Task has been added!',
      name: 'add_task_success',
      desc: '',
      args: [],
    );
  }

  /// `Back to task list`
  String get back_to_task_list {
    return Intl.message(
      'Back to task list',
      name: 'back_to_task_list',
      desc: '',
      args: [],
    );
  }

  /// `Repeat task`
  String get repeat_task {
    return Intl.message(
      'Repeat task',
      name: 'repeat_task',
      desc: '',
      args: [],
    );
  }

  /// `Never`
  String get never {
    return Intl.message(
      'Never',
      name: 'never',
      desc: '',
      args: [],
    );
  }

  /// `Every day`
  String get every_day {
    return Intl.message(
      'Every day',
      name: 'every_day',
      desc: '',
      args: [],
    );
  }

  /// `Every week`
  String get every_week {
    return Intl.message(
      'Every week',
      name: 'every_week',
      desc: '',
      args: [],
    );
  }

  /// `Every month`
  String get every_month {
    return Intl.message(
      'Every month',
      name: 'every_month',
      desc: '',
      args: [],
    );
  }

  /// `Every year`
  String get every_year {
    return Intl.message(
      'Every year',
      name: 'every_year',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate task`
  String get duplicate_task {
    return Intl.message(
      'Duplicate task',
      name: 'duplicate_task',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Task does not exist`
  String get delete_task_error {
    return Intl.message(
      'Task does not exist',
      name: 'delete_task_error',
      desc: '',
      args: [],
    );
  }

  /// `Task has been deleted!`
  String get delete_task_success {
    return Intl.message(
      'Task has been deleted!',
      name: 'delete_task_success',
      desc: '',
      args: [],
    );
  }

  /// `Task not found`
  String get task_not_found {
    return Intl.message(
      'Task not found',
      name: 'task_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Cannot update this task!`
  String get update_task_error {
    return Intl.message(
      'Cannot update this task!',
      name: 'update_task_error',
      desc: '',
      args: [],
    );
  }

  /// `Task has been updated!`
  String get update_task_success {
    return Intl.message(
      'Task has been updated!',
      name: 'update_task_success',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get current_language {
    return Intl.message(
      'English',
      name: 'current_language',
      desc: '',
      args: [],
    );
  }

  /// `Switch`
  String get switch_language {
    return Intl.message(
      'Switch',
      name: 'switch_language',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Remind due tasks`
  String get notification_description {
    return Intl.message(
      'Remind due tasks',
      name: 'notification_description',
      desc: '',
      args: [],
    );
  }

  /// `You have {countIncompleted} tasks to do today`
  String notification_title(int countIncompleted) {
    return Intl.message(
      'You have $countIncompleted tasks to do today',
      name: 'notification_title',
      desc: '',
      args: [countIncompleted],
    );
  }

  /// `hahaha`
  String get hahahaa {
    return Intl.message(
      'hahaha',
      name: 'hahahaa',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
