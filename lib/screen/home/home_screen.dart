import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screen/home/widgets/new_task_form.dart';
import 'package:todo_app/screen/home/widgets/search_bar.dart';
import 'package:todo_app/screen/home/widgets/tasks_card.dart';
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
  int _page = 1;
  final _searchController = TextEditingController();
  final List<Task> _allTasks = [];
  final List<Task> _todayTasks = [];
  final List<Task> _upcomingTasks = [];

  _loadTasks([String? keyword]) {
    homeBloc.add(LoadTasks(keyword));
  }

  List<Task> get _tasksToShow {
    switch (_page) {
      case 0:
        return _allTasks;
      case 1:
        return _todayTasks;
      case 2:
        return _upcomingTasks;
      default:
        return [];
    }
  }

  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: homeBloc,
      listenWhen: (prev, curr) =>
          curr is HomeLoading ||
          curr is HomeError ||
          curr is TaskDeleted ||
          curr is TasksLoaded,
      listener: (ctx, state) {
        hideLoadingDialog();
        if (state is HomeLoading) {
          showLoadingDialog();
        } else if (state is HomeError) {
          showErrorDialog(context, state.error);
        } else if (state is TaskDeleted) {
          showMessage(context, 'Task has been deleted!');
        } else if (state is TasksLoaded) {
          setState(() {
            _allTasks.clear();
            _todayTasks.clear();
            _upcomingTasks.clear();
            _allTasks.addAll(state.allTasks);
            _todayTasks.addAll(state.todayTasks);
            _upcomingTasks.addAll(state.upcomingTasks);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: SearchBar(
            controller: _searchController,
            onSearch: (keyword) => _loadTasks(keyword),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: TasksCard(_tasksToShow),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
          elevation: 0,
          onPressed: () => _handleTask(context),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.ballot_outlined),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upcoming_outlined),
              label: 'Upcoming',
            ),
          ],
          currentIndex: _page,
          selectedItemColor: AppColors.secondary,
          onTap: (index) {
            if (_page == index) return;
            setState(() {
              _page = index;
            });
          },
        ),
      ),
    );
  }

  // taskId == null: add new task
  // taskId != null: edit task
  _handleTask(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (mbsContext) => NewTaskForm(onSubmit: (msg) {
        _loadTasks();
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
}
