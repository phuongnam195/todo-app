import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/screen/home/home_screen.dart';
import 'package:todo_app/util/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primaryColor: AppColor.primary,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
