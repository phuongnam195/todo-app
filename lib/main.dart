import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_app/repository/task_repository.dart';
import 'package:todo_app/screen/home/home_screen.dart';
import 'package:todo_app/util/constants.dart';
import 'package:todo_app/util/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  TaskRepository().init();
  NotificationService().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: Colors.white,
          secondary: AppColors.secondary,
          onSecondary: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: const HomeScreen(),
    );
  }
}
