import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/screen/home/task_handler_form.dart';
import 'package:todo_app/screen/home/tasks_card.dart';
import 'package:todo_app/screen/setting/setting_screen.dart';
import 'package:todo_app/util/constants.dart';
import 'package:todo_app/util/dialog_utils.dart';

import 'home_bloc.dart';

final homeBloc = HomeBloc();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with DialogUtils {
  int _currentPageIndex = 1;

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: homeBloc,
      listenWhen: (prev, curr) =>
          curr is HomeLoading || curr is HomeError || curr is TaskDeleted,
      listener: (ctx, state) {
        hideLoadingDialog();
        if (state is HomeLoading) {
          showLoadingDialog(context);
        } else if (state is HomeError) {
          showErrorDialog(context, state.error);
        } else if (state is TaskDeleted) {
          showMessage(context, S.current.delete_task_success);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () async {
              var languageChanged = await Navigator.of(context)
                  .pushNamed(SettingScreen.routeName);
              if (languageChanged == true) {
                _refresh();
              }
            },
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
            bloc: homeBloc,
            buildWhen: (prev, curr) => curr is TasksLoaded,
            builder: (ctx, state) {
              hideLoadingDialog();
              if (state is TasksLoaded) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: state.mapTasks.entries
                          .map(
                            (e) => TasksCard(
                              key: Key(e.toString()),
                              title: e.key,
                              tasks: e.value,
                              onEditTask: (taskId) =>
                                  _handleTask(context, taskId),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              }
              return Container();
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primary,
          child: const Icon(Icons.add),
          elevation: 0,
          onPressed: () => _handleTask(context),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.done_all_outlined),
              label: S.current.complete,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.ballot_outlined),
              label: S.current.all,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.rule),
              label: S.current.incomplete,
            ),
          ],
          currentIndex: _currentPageIndex,
          selectedItemColor: AppColor.secondary,
          onTap: (index) {
            if (_currentPageIndex == index) return;
            setState(() {
              _currentPageIndex = index;
            });
            _refresh();
          },
        ),
      ),
    );
  }

  // taskId == null: add new task
  // taskId != null: edit task
  _handleTask(BuildContext context, [int? taskId]) async {
    showModalBottomSheet(
      context: context,
      builder: (mbsContext) => TaskHandlerForm(
          taskId: taskId,
          onDone: (msg) {
            _refresh();
            Navigator.of(mbsContext).pop();
            if (msg != null) {
              showMessage(context, msg);
            }
          }),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
    );
  }

  _refresh() {
    switch (_currentPageIndex) {
      case 0:
        homeBloc.add(LoadTasks(completed: true));
        break;
      case 1:
        homeBloc.add(LoadTasks());
        break;
      case 2:
        homeBloc.add(LoadTasks(completed: false));
        break;
    }
  }
}
