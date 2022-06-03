import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/screen/home/home_screen.dart';
import 'package:todo_app/screen/splash/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final splashBloc = SplashBloc();
    splashBloc.add(InitData());
    return BlocListener<SplashBloc, SplashState>(
      bloc: splashBloc,
      listenWhen: (prev, curr) => curr is DataInitialized,
      listener: (ctx, state) {
        if (state is DataInitialized) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      },
      child: const Center(child: Text('SplashScreen')),
    );
  }
}
