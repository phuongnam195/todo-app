import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/core/setting.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/model/repeat_type.dart';
import 'package:todo_app/repository/task_repository.dart';

import 'logger.dart';

class ServiceUtils {
  static const Time _handleRepeatTaskTime = Time(23, 55, 0);
  static const Time _notificationTime = Time(17, 0, 0);

  static Future<void> run() async {
    await AndroidAlarmManager.initialize();
    _scheduleRepeatTaskHandling();

    // TODO: fix bug
    // await _initNotification();
    // _scheduleNotification();
  }

  static Future<void> _scheduleRepeatTaskHandling() async {
    if (Platform.isAndroid) {
      await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        0,
        _handleRepeatTasks,
        wakeup: false,
        exact: true,
        startAt: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            _handleRepeatTaskTime.hour,
            _handleRepeatTaskTime.minute),
        rescheduleOnReboot: true,
      );
    } else {
      // TODO: handle in other platforms
    }
  }

  static Future<void> _handleRepeatTasks() async {
    final taskRepo = TaskRepository();
    final tasks = await taskRepo.getTodayTasks();
    for (var task in tasks) {
      if (task.isRepeated) {
        final newTask = task.copyWith(
          dueDate: task.repeatType.nextDate(task.dueDate),
          isCompleted: false,
          completedDate: null,
        );
        await taskRepo.addTask(newTask);
        if (task.isCompleted) {
          await taskRepo.deleteTask(task.id);
        }
      }
    }
  }

  static final FlutterLocalNotificationsPlugin _notiPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> _scheduleNotification() async {
    if (Platform.isAndroid) {
      await AndroidAlarmManager.periodic(
        const Duration(minutes: 1),
        0,
        _showNotification,
        wakeup: false,
        exact: true,
        startAt: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            _notificationTime.hour,
            _notificationTime.minute),
        rescheduleOnReboot: true,
      );
    } else {
      // TODO: handle in other platforms
    }
  }

  static Future<void> _initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await _notiPlugin.initialize(initializationSettings);
  }

  static Future<void> _showNotification() async {
    Logger.d('ServiceUtils._showNotification()');
    await Setting().init();
    final ok = Setting().getNotification();
    if (!ok) return;
    final taskRepo = TaskRepository();
    final todayTasks = await taskRepo.getTodayTasks();
    final incompletedTasks =
        todayTasks.where((task) => !task.isCompleted).toList();
    final countIncompleted = incompletedTasks.length;

    if (countIncompleted > 0) {
      String title = S.current.notification_title(countIncompleted);
      String body = incompletedTasks[0].title;
      if (countIncompleted > 1) {
        body += ', ' + incompletedTasks[1].title;
      }
      if (countIncompleted > 2) {
        body += '...';
      }
      await _notiPlugin.show(
        1,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails('main_channel', 'Main Channel',
              channelDescription: "ashwin",
              importance: Importance.max,
              priority: Priority.max),
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }
}
