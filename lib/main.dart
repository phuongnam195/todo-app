import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/screen/home/home_screen.dart';
import 'package:todo_app/screen/splash/splash_screen.dart';
import 'package:todo_app/util/constants.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'screen/setting/setting_screen.dart';

void main() {
  initializeDateFormatting();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          onPrimary: Colors.white,
          secondary: AppColor.secondary,
          onSecondary: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (ctx) => const SplashScreen(),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        SettingScreen.routeName: (ctx) => const SettingScreen(),
      },
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
